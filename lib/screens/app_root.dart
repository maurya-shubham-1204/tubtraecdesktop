import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/db/app_database.dart';
import 'package:tubtrace_desktop/screens/import_prompt_page.dart';
import 'package:tubtrace_desktop/screens/lab_registration_page.dart';
import 'package:tubtrace_desktop/screens/unlock_page.dart';
import 'package:tubtrace_desktop/services/auth_service.dart';
import 'package:tubtrace_desktop/services/backup_service.dart';
import 'package:tubtrace_desktop/shell/tenant_shell.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/window_chrome.dart';
import 'package:tubtrace_desktop/window_sizes.dart';

enum _BootPhase { loading, error, register, unlock, importPrompt, home }

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late AppDatabase _db;
  late AuthService _auth;
  late BackupService _backup;
  _BootPhase _phase = _BootPhase.loading;
  bool _unlocked = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _auth = AuthService(_db);
    _backup = BackupService(_db);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() {
      _phase = _BootPhase.loading;
      _error = null;
    });
    try {
      await _db.ensureSettingsRow();
      final s = await _auth.settings();
      if (!mounted) return;

      if (!s.registered) {
        await openSetupCardWindow();
        if (!mounted) return;
        setState(() => _phase = _BootPhase.register);
        return;
      }

      if (s.securityEnabled && !_unlocked) {
        await openCardWindow(size: kCardWindowSize);
        if (!mounted) return;
        setState(() => _phase = _BootPhase.unlock);
        return;
      }

      if (!s.importPromptDone) {
        await openCardWindow(size: kCardWindowSize);
        if (!mounted) return;
        setState(() {
          _unlocked = true;
          _phase = _BootPhase.importPrompt;
        });
        return;
      }

      setState(() {
        _unlocked = true;
        _phase = _BootPhase.home;
      });
      await openMainWindow();
    } catch (e) {
      if (!mounted) return;
      await openCardWindow(size: kCardWindowSize);
      if (!mounted) return;
      setState(() {
        _phase = _BootPhase.error;
        _error = e.toString();
      });
    }
  }

  Future<void> _afterRegister() async {
    final s = await _auth.settings();
    if (!mounted) return;

    if (!s.importPromptDone) {
      await openCardWindow(size: kCardWindowSize);
      if (!mounted) return;
      setState(() {
        _unlocked = true;
        _phase = _BootPhase.importPrompt;
      });
      return;
    }

    setState(() {
      _unlocked = true;
      _phase = _BootPhase.home;
    });
    await openMainWindow();
  }

  Future<void> _afterUnlock() async {
    final s = await _auth.settings();
    if (!mounted) return;

    if (!s.importPromptDone) {
      await openCardWindow(size: kCardWindowSize);
      if (!mounted) return;
      setState(() {
        _unlocked = true;
        _phase = _BootPhase.importPrompt;
      });
      return;
    }

    setState(() {
      _unlocked = true;
      _phase = _BootPhase.home;
    });
    await openMainWindow();
  }

  Future<void> _afterImportPrompt() async {
    if (!mounted) return;
    setState(() {
      _unlocked = true;
      _phase = _BootPhase.home;
    });
    await openMainWindow();
  }

  Future<void> _rebindDatabase(AppDatabase newDb) async {
    final old = _db;
    _db = newDb;
    _auth = AuthService(_db);
    _backup = BackupService(_db);
    if (mounted) setState(() {});
    try {
      await old.close();
    } catch (_) {}
  }

  Future<void> _retry() async {
    try {
      await _db.close();
    } catch (_) {}
    _db = AppDatabase();
    _auth = AuthService(_db);
    _backup = BackupService(_db);
    await _bootstrap();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      db: _db,
      auth: _auth,
      backup: _backup,
      unlocked: _unlocked,
      setUnlocked: (v) {
        if (mounted) setState(() => _unlocked = v);
      },
      rebindDatabase: _rebindDatabase,
      child: KeyedSubtree(
        key: ValueKey(_phase),
        child: switch (_phase) {
          _BootPhase.loading => Material(
              color: AppColors.splashBg,
              child: const Center(child: CircularProgressIndicator(color: Colors.white)),
            ),
          _BootPhase.error => Material(
              color: AppColors.splashBg,
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.red, size: 36),
                    const SizedBox(height: 12),
                    const Text(
                      'Database error',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _error ?? 'Unknown',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.65), fontSize: 12),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(onPressed: _retry, child: const Text('Retry')),
                  ],
                ),
              ),
            ),
          _BootPhase.register => LabRegistrationPage(onCompleted: _afterRegister),
          _BootPhase.unlock => UnlockPage(onUnlocked: _afterUnlock),
          _BootPhase.importPrompt => ImportPromptPage(onDone: _afterImportPrompt),
          _BootPhase.home => const TenantShell(),
        },
      ),
    );
  }
}
