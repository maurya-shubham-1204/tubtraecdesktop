import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/splash_card_shell.dart';

class ImportPromptPage extends StatefulWidget {
  const ImportPromptPage({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  State<ImportPromptPage> createState() => _ImportPromptPageState();
}

class _ImportPromptPageState extends State<ImportPromptPage> {
  bool _busy = false;
  String? _message;

  Future<void> _skip() async {
    await AppScope.read(context).auth.markImportPromptDone();
    if (!mounted) return;
    widget.onDone();
  }

  Future<void> _import() async {
    final scope = AppScope.read(context);
    final settings = await scope.auth.settings();
    if (!mounted) return;
    final keyCtrl = TextEditingController(text: settings.licenseKey);
    final licenseKey = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('License key'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter the registration license key that encrypted this .tt file.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: keyCtrl,
              obscureText: true,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'License key'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
            onPressed: () => Navigator.pop(context, keyCtrl.text.trim()),
            child: const Text('Import'),
          ),
        ],
      ),
    );
    keyCtrl.dispose();
    if (licenseKey == null || licenseKey.isEmpty || !mounted) return;

    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      final path = await scope.backup.pickImportFile();
      if (path == null) {
        if (mounted) setState(() => _busy = false);
        return;
      }
      await scope.backup.importBackup(backupPath: path, licenseKey: licenseKey);
      await scope.auth.markImportPromptDone();
      if (!mounted) return;
      setState(() => _message = 'Imported successfully');
      await Future<void>.delayed(const Duration(milliseconds: 450));
      if (!mounted) return;
      widget.onDone();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _message = 'Import failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashCardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SplashBrandMark(size: 56),
          const SizedBox(height: 14),
          const Text(
            'Import a .tt backup?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Encrypted with your registration license key. You can also import later from Settings.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12),
          ),
          const Spacer(),
          if (_message != null) ...[
            Text(
              _message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _message!.startsWith('Import failed') ? AppColors.red : AppColors.green,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 12),
          ],
          FilledButton.icon(
            onPressed: _busy ? null : _import,
            icon: const Icon(Icons.lock_open_rounded),
            label: Text(_busy ? 'Working…' : 'Import .tt'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
            ),
            onPressed: _busy ? null : _skip,
            child: const Text('Skip for now'),
          ),
        ],
      ),
    );
  }
}
