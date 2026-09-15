import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:drift/drift.dart';

class LicenseService {
  /// Offline validation rules for lab activation.
  /// Demo credentials always work: DEMO01 / DEMO-KEY-2026 / 1.0
  static String? validate({
    required String labCode,
    required String key,
    required String ver,
  }) {
    final code = labCode.trim();
    final k = key.trim();
    final v = ver.trim();

    if (code.length < 3) return 'Lab code must be at least 3 characters.';
    if (!RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(code)) {
      return 'Lab code can only contain letters, numbers, _ and -.';
    }
    if (k.length < 6) return 'License key must be at least 6 characters.';
    if (v.isEmpty) return 'Version is required.';
    if (!RegExp(r'^\d+(\.\d+)*$').hasMatch(v)) {
      return 'Version must look like 1.0 or 1.0.1';
    }

    final demoOk = code.toUpperCase() == 'DEMO01' &&
        k.toUpperCase() == 'DEMO-KEY-2026' &&
        v == '1.0';
    if (demoOk) return null;

    // Accept any well-formed offline license for local-only mode.
    return null;
  }
}

class AuthService {
  AuthService(this.db);

  final AppDatabase db;

  /// Encryption secret for .tt archives: wraps the registration license key.
  static String backupSecretFromLicenseKey(String licenseKey) {
    final key = licenseKey.trim();
    if (key.isEmpty) {
      throw StateError('License key is missing. Re-register this lab first.');
    }
    return 'tubetrace_${key}_tubetrace';
  }

  Future<String> backupSecret() async {
    final s = await settings();
    return backupSecretFromLicenseKey(s.licenseKey);
  }

  Future<AppSetting> settings() => db.ensureSettingsRow();

  Future<bool> get isRegistered async => (await settings()).registered;

  Future<bool> get isSecurityEnabled async => (await settings()).securityEnabled;

  Future<bool> get isImportPromptDone async => (await settings()).importPromptDone;

  static String _hash(String password, String salt) {
    final bytes = utf8.encode('$salt::$password');
    return sha256.convert(bytes).toString();
  }

  static String _newSalt() {
    final r = Random.secure();
    final bytes = List<int>.generate(16, (_) => r.nextInt(256));
    return base64UrlEncode(bytes);
  }

  Future<void> completeRegistration({
    required String labCode,
    required String key,
    required String ver,
    required bool enableSecurity,
    String? password,
    String? labName,
  }) async {
    final salt = enableSecurity ? _newSalt() : null;
    final hash = enableSecurity && password != null ? _hash(password, salt!) : null;

    await db.into(db.appSettings).insertOnConflictUpdate(
          AppSettingsCompanion(
            id: const Value(1),
            labCode: Value(labCode.trim()),
            licenseKey: Value(key.trim()),
            licenseVer: Value(ver.trim()),
            labName: Value((labName?.trim().isNotEmpty ?? false) ? labName!.trim() : 'My Lab'),
            registered: const Value(true),
            securityEnabled: Value(enableSecurity),
            passwordHash: Value(hash),
            passwordSalt: Value(salt),
            importPromptDone: const Value(false),
            registeredAt: Value(DateTime.now()),
          ),
        );
    await db.seedDefaultsIfEmpty();
  }

  Future<bool> verifyPassword(String password) async {
    final s = await settings();
    if (!s.securityEnabled || s.passwordHash == null || s.passwordSalt == null) {
      return true;
    }
    return _hash(password, s.passwordSalt!) == s.passwordHash;
  }

  Future<void> setSecurity({required bool enabled, String? password}) async {
    if (!enabled) {
      await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
        const AppSettingsCompanion(
          securityEnabled: Value(false),
          passwordHash: Value(null),
          passwordSalt: Value(null),
        ),
      );
      return;
    }
    if (password == null || password.length < 4) {
      throw ArgumentError('Password must be at least 4 characters.');
    }
    final salt = _newSalt();
    await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
      AppSettingsCompanion(
        securityEnabled: const Value(true),
        passwordSalt: Value(salt),
        passwordHash: Value(_hash(password, salt)),
      ),
    );
  }

  Future<void> markImportPromptDone() async {
    await (db.update(db.appSettings)..where((t) => t.id.equals(1))).write(
      const AppSettingsCompanion(importPromptDone: Value(true)),
    );
  }
}
