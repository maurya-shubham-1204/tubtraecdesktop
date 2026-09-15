import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/auth_service.dart';
import 'package:tubtrace_desktop/services/portable_pack.dart';
import 'package:tubtrace_desktop/services/tt_crypto.dart';

class BackupService {
  BackupService(this.db);

  AppDatabase db;

  void bind(AppDatabase next) => db = next;

  /// Encrypts with registration license key: `tubetrace_<key>_tubetrace`.
  Future<String?> exportBackup() async {
    final secret = await AuthService(db).backupSecret();
    final payload = await PortablePack.exportJson(db);
    final json = const JsonEncoder.withIndent('  ').convert(payload);
    final bytes = await TtCrypto.encryptUtf8(json, secret);

    final stamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    final path = await FilePicker.saveFile(
      dialogTitle: 'Export TubTrace (.tt)',
      fileName: 'tubtrace_backup_$stamp.tt',
      type: FileType.custom,
      allowedExtensions: const ['tt'],
    );
    if (path == null) return null;

    final out = path.endsWith('.tt') ? path : '$path.tt';
    await File(out).writeAsBytes(bytes, flush: true);
    return out;
  }

  Future<String?> pickImportFile() async {
    final result = await FilePicker.pickFiles(
      dialogTitle: 'Import TubTrace (.tt)',
      type: FileType.custom,
      allowedExtensions: const ['tt'],
      allowMultiple: false,
      withData: false,
    );
    if (result == null || result.files.isEmpty) return null;
    return result.files.single.path;
  }

  /// Decrypts with the license key that encrypted the archive.
  Future<void> importBackup({
    required String backupPath,
    required String licenseKey,
  }) async {
    final file = File(backupPath);
    if (!await file.exists()) {
      throw StateError('Backup file not found.');
    }
    final bytes = Uint8List.fromList(await file.readAsBytes());
    if (!TtCrypto.looksLikeTt(bytes)) {
      throw const FormatException('Selected file is not an encrypted .tt backup.');
    }
    final secret = AuthService.backupSecretFromLicenseKey(licenseKey);
    final jsonText = await TtCrypto.decryptUtf8(bytes, secret);
    final decoded = jsonDecode(jsonText);
    if (decoded is! Map) {
      throw const FormatException('Invalid .tt payload.');
    }
    await PortablePack.importJson(db, Map<String, dynamic>.from(decoded));
    await db.ensureSettingsRow();
  }
}
