import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/services/auth_service.dart';
import 'package:tubtrace_desktop/services/backup_service.dart';

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.db,
    required this.auth,
    required this.backup,
    required this.unlocked,
    required this.setUnlocked,
    required this.rebindDatabase,
    required super.child,
  });

  final AppDatabase db;
  final AuthService auth;
  final BackupService backup;
  final bool unlocked;
  final ValueChanged<bool> setUnlocked;
  final Future<void> Function(AppDatabase newDb) rebindDatabase;

  /// Subscribes [context] to changes (rebuild on notify).
  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!;
  }

  /// One-shot access — does not register a dependency (safer across async gaps).
  static AppScope read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) {
    return db != oldWidget.db ||
        unlocked != oldWidget.unlocked ||
        auth != oldWidget.auth ||
        backup != oldWidget.backup;
  }
}
