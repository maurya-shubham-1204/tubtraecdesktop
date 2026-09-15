import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/brand_logo.dart';
import 'package:tubtrace_desktop/widgets/splash_card_shell.dart';
import 'package:window_manager/window_manager.dart';

class UnlockPage extends StatefulWidget {
  const UnlockPage({
    super.key,
    required this.onUnlocked,
    this.labName,
  });

  final Future<void> Function() onUnlocked;
  final String? labName;

  @override
  State<UnlockPage> createState() => _UnlockPageState();
}

class _UnlockPageState extends State<UnlockPage> {
  final _pass = TextEditingController();
  final _focus = FocusNode();
  String? _error;
  bool _busy = false;
  bool _obscure = true;
  late String _labName = widget.labName ?? 'TubTrace';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focus.requestFocus();
    });
    if (widget.labName != null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      try {
        final s = await AppScope.read(context).auth.settings();
        if (mounted) setState(() => _labName = s.labName);
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    _pass.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _exitApp() async {
    try {
      await windowManager.destroy();
    } catch (_) {
      exit(0);
    }
  }

  Future<void> _unlock() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final ok = await AppScope.read(context).auth.verifyPassword(_pass.text);
      if (!mounted) return;
      if (!ok) {
        setState(() {
          _busy = false;
          _error = 'Incorrect password';
        });
        _focus.requestFocus();
        return;
      }
      await widget.onUnlocked();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Unlock failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashCardShell(
      padding: const EdgeInsets.fromLTRB(26, 22, 26, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _busy ? null : _exitApp,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white54,
                visualDensity: VisualDensity.compact,
              ),
              icon: const Icon(Icons.power_settings_new, size: 16),
              label: const Text('Exit'),
            ),
          ),
          const SizedBox(height: 4),
          const Center(child: BrandLogo(size: 64, radius: 16, padding: 8)),
          const SizedBox(height: 14),
          Text(
            _labName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            'App is locked',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.45), fontSize: 12),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: _pass,
            focusNode: _focus,
            obscureText: _obscure,
            onSubmitted: (_) => _unlock(),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter password',
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.07),
              labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
              prefixIcon: Icon(Icons.key_rounded, color: Colors.white.withValues(alpha: 0.55), size: 20),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: Colors.white54,
                  size: 18,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.splashProgress, width: 1.4),
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.error_outline, color: AppColors.red, size: 14),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(_error!, style: const TextStyle(color: AppColors.red, fontSize: 12)),
                ),
              ],
            ),
          ],
          const Spacer(),
          FilledButton(
            onPressed: _busy ? null : _unlock,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _busy
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Unlock'),
          ),
          const SizedBox(height: 6),
          Text(
            'TubTrace · Offline',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.28), fontSize: 11),
          ),
        ],
      ),
    );
  }
}
