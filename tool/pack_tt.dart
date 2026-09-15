// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:tubtrace_desktop/services/auth_service.dart';
import 'package:tubtrace_desktop/services/tt_crypto.dart';

/// Pack portable JSON into an encrypted .tt for desktop import.
///
/// Usage:
///   dart run tool/pack_tt.dart <input.json> <licenseKey> [output.tt]
Future<void> main(List<String> args) async {
  if (args.length < 2) {
    stderr.writeln('Usage: dart run tool/pack_tt.dart <input.json> <licenseKey> [output.tt]');
    exit(64);
  }
  final input = File(args[0]);
  if (!await input.exists()) {
    stderr.writeln('Missing input: ${args[0]}');
    exit(66);
  }
  final licenseKey = args[1].trim();
  final outPath = args.length >= 3
      ? args[2]
      : args[0].replaceAll(RegExp(r'\.json$', caseSensitive: false), '.tt');

  final jsonText = await input.readAsString();
  // Validate JSON shape lightly.
  final decoded = jsonDecode(jsonText);
  if (decoded is! Map || decoded['format'] != 'tubtrace.portable') {
    stderr.writeln('Input is not tubtrace.portable JSON');
    exit(65);
  }

  final secret = AuthService.backupSecretFromLicenseKey(licenseKey);
  final bytes = await TtCrypto.encryptUtf8(jsonText, secret);
  final out = File(outPath);
  await out.writeAsBytes(bytes, flush: true);
  print('Wrote ${out.path} (${bytes.length} bytes)');
  print('Import in desktop with license key: $licenseKey');
}
