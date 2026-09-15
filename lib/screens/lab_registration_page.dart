import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/app_scope.dart';
import 'package:tubtrace_desktop/services/auth_service.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/splash_card_shell.dart';
import 'package:tubtrace_desktop/window_chrome.dart';
import 'package:tubtrace_desktop/window_sizes.dart';

enum _RegStep { license, security, password }

class LabRegistrationPage extends StatefulWidget {
  const LabRegistrationPage({super.key, required this.onCompleted});

  final VoidCallback onCompleted;

  @override
  State<LabRegistrationPage> createState() => _LabRegistrationPageState();
}

class _LabRegistrationPageState extends State<LabRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _labCode = TextEditingController();
  final _key = TextEditingController();
  final _ver = TextEditingController(text: '1.0');
  final _labName = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  final _passFormKey = GlobalKey<FormState>();

  _RegStep _step = _RegStep.license;
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _labCode.dispose();
    _key.dispose();
    _ver.dispose();
    _labName.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  InputDecoration _field(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.06),
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.35)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.splashProgress),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.red),
      ),
    );
  }

  Future<void> _setStep(_RegStep step) async {
    setState(() {
      _step = step;
      _error = null;
    });
    // Slightly taller for license form; compact for other steps.
    final size = step == _RegStep.license ? kSetupCardWindowSize : kCardWindowSize;
    await openSetupCardWindow(size: size);
  }

  void _goLicenseContinue() {
    setState(() => _error = null);
    if (!_formKey.currentState!.validate()) return;
    final licenseError = LicenseService.validate(
      labCode: _labCode.text,
      key: _key.text,
      ver: _ver.text,
    );
    if (licenseError != null) {
      setState(() => _error = licenseError);
      return;
    }
    _setStep(_RegStep.security);
  }

  Future<void> _finish({required bool enableSecurity, String? password}) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final auth = AppScope.read(context).auth;
      await auth.completeRegistration(
        labCode: _labCode.text,
        key: _key.text,
        ver: _ver.text,
        enableSecurity: enableSecurity,
        password: password,
        labName: _labName.text,
      );
      if (!mounted) return;
      widget.onCompleted();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = 'Registration failed: $e';
      });
      await _setStep(_RegStep.license);
    }
  }

  void _savePassword() {
    if (!_passFormKey.currentState!.validate()) return;
    _finish(enableSecurity: true, password: _pass.text);
  }

  @override
  Widget build(BuildContext context) {
    return SplashCardShell(
      child: switch (_step) {
        _RegStep.license => _licenseBody(),
        _RegStep.security => _securityBody(),
        _RegStep.password => _passwordBody(),
      },
    );
  }

  Widget _licenseBody() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              SplashBrandMark(size: 42),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register computer',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'One-time offline activation',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: _labName,
                    style: const TextStyle(color: Colors.white),
                    decoration: _field('Lab name (optional)', hint: 'Demo Pathology Lab'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _labCode,
                    style: const TextStyle(color: Colors.white),
                    textCapitalization: TextCapitalization.characters,
                    decoration: _field('Lab code *', hint: 'DEMO01'),
                    validator: (v) => (v == null || v.trim().length < 3) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _key,
                    style: const TextStyle(color: Colors.white),
                    decoration: _field('License key *', hint: 'DEMO-KEY-2026'),
                    validator: (v) => (v == null || v.trim().length < 6) ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _ver,
                    style: const TextStyle(color: Colors.white),
                    decoration: _field('Version *', hint: '1.0'),
                    validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 10),
                    Text(_error!, style: const TextStyle(color: AppColors.red, fontSize: 12)),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: _busy ? null : _goLicenseContinue,
            child: const Text('Continue'),
          ),
          const SizedBox(height: 8),
          Text(
            'DEMO01 / DEMO-KEY-2026 / 1.0',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _securityBody() {
    return Column(
      children: [
        const SplashBrandMark(size: 44),
        const SizedBox(height: 16),
        const Text(
          'Enable security?',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Protect this app with a password when anyone opens it on this computer.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13),
        ),
        const Spacer(),
        if (_error != null) ...[
          Text(_error!, style: const TextStyle(color: AppColors.red, fontSize: 12)),
          const SizedBox(height: 10),
        ],
        FilledButton(
          onPressed: _busy ? null : () => _setStep(_RegStep.password),
          child: const Text('Yes, secure it'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white70,
            side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
          onPressed: _busy ? null : () => _finish(enableSecurity: false),
          child: _busy
              ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Not now'),
        ),
        TextButton(
          onPressed: _busy ? null : () => _setStep(_RegStep.license),
          child: const Text('Back', style: TextStyle(color: Colors.white54)),
        ),
      ],
    );
  }

  Widget _passwordBody() {
    return Form(
      key: _passFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SplashBrandMark(size: 44),
          const SizedBox(height: 14),
          const Text(
            'Create password',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Needed each time the app opens',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _pass,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: _field('Password'),
            validator: (v) => (v == null || v.length < 4) ? 'Min 4 characters' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _confirm,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: _field('Confirm password'),
            validator: (v) => v != _pass.text ? 'Passwords do not match' : null,
          ),
          if (_error != null) ...[
            const SizedBox(height: 10),
            Text(_error!, style: const TextStyle(color: AppColors.red, fontSize: 12)),
          ],
          const Spacer(),
          FilledButton(
            onPressed: _busy ? null : _savePassword,
            child: _busy
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Save & continue'),
          ),
          TextButton(
            onPressed: _busy ? null : () => _setStep(_RegStep.security),
            child: const Text('Back', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }
}
