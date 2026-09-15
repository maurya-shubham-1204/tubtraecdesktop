import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

/// Encrypted TubTrace portable archive (.tt).
///
/// Binary layout:
/// - magic "TT01" (4)
/// - version u8 (=1)
/// - salt 16 bytes
/// - nonce 12 bytes
/// - AES-256-GCM ciphertext + 16-byte mac
class TtCrypto {
  static const magic = [0x54, 0x54, 0x30, 0x31]; // TT01
  static const formatVersion = 1;
  static const _iters = 120000;

  static final _aes = AesGcm.with256bits();
  static final _pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: _iters,
    bits: 256,
  );

  static Uint8List _random(int n) {
    final r = Random.secure();
    return Uint8List.fromList(List<int>.generate(n, (_) => r.nextInt(256)));
  }

  static Future<SecretKey> _deriveKey(String password, List<int> salt) {
    return _pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );
  }

  static Future<Uint8List> encryptUtf8(String plaintext, String password) async {
    final salt = _random(16);
    final key = await _deriveKey(password, salt);
    final secretBox = await _aes.encrypt(
      utf8.encode(plaintext),
      secretKey: key,
    );

    final out = BytesBuilder(copy: false);
    out.add(magic);
    out.addByte(formatVersion);
    out.add(salt);
    out.add(secretBox.nonce);
    out.add(secretBox.cipherText);
    out.add(secretBox.mac.bytes);
    return out.toBytes();
  }

  static Future<String> decryptUtf8(Uint8List bytes, String password) async {
    if (bytes.length < 4 + 1 + 16 + 12 + 16) {
      throw const FormatException('File is too small to be a .tt backup.');
    }
    for (var i = 0; i < 4; i++) {
      if (bytes[i] != magic[i]) {
        throw const FormatException('Not a TubTrace .tt file.');
      }
    }
    final version = bytes[4];
    if (version != formatVersion) {
      throw FormatException('Unsupported .tt version: $version');
    }
    final salt = bytes.sublist(5, 21);
    final nonce = bytes.sublist(21, 33);
    final body = bytes.sublist(33);
    if (body.length < 17) {
      throw const FormatException('Corrupt .tt payload.');
    }
    final cipherText = body.sublist(0, body.length - 16);
    final macBytes = body.sublist(body.length - 16);

    final key = await _deriveKey(password, salt);
    try {
      final clear = await _aes.decrypt(
        SecretBox(cipherText, nonce: nonce, mac: Mac(macBytes)),
        secretKey: key,
      );
      return utf8.decode(clear);
    } catch (_) {
      throw const FormatException('Wrong password or corrupt .tt file.');
    }
  }

  static bool looksLikeTt(Uint8List bytes) {
    if (bytes.length < 5) return false;
    for (var i = 0; i < 4; i++) {
      if (bytes[i] != magic[i]) return false;
    }
    return true;
  }
}
