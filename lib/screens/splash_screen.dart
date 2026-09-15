import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/screens/app_root.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/widgets/brand_logo.dart';
import 'package:tubtrace_desktop/window_sizes.dart';
import 'package:window_manager/window_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _statusLines = [
    'Loading modules…',
    'Opening local database…',
    'Preparing workspace…',
    'Checking registration…',
    'Almost ready…',
  ];

  late final AnimationController _progressController;
  int _statusIndex = 0;
  Timer? _statusTimer;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _lockSplashWindow());

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _goNext();
        }
      });

    _statusTimer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      if (!mounted) return;
      setState(() => _statusIndex = (_statusIndex + 1) % _statusLines.length);
    });

    _progressController.forward();
  }

  Future<void> _lockSplashWindow() async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.setResizable(false);
    await windowManager.setMinimumSize(kSplashWindowSize);
    await windowManager.setMaximumSize(kSplashWindowSize);
    await windowManager.setSize(kSplashWindowSize);
    await windowManager.center();
  }

  Future<void> _goNext() async {
    if (_navigating || !mounted) return;
    _navigating = true;
    _statusTimer?.cancel();

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (_, __, ___) => const AppRoot(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.splashBg,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 22),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const BrandLogo(size: 56, radius: 14, padding: 6),
            const SizedBox(height: 16),
            const Text(
              'TubTrace',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Offline lab desktop',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.55), fontSize: 12),
            ),
            const Spacer(flex: 3),
            AnimatedBuilder(
              animation: _progressController,
              builder: (context, _) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: _progressController.value,
                    minHeight: 3,
                    backgroundColor: Colors.white.withValues(alpha: 0.12),
                    valueColor: AlwaysStoppedAnimation(AppColors.splashProgress),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _statusLines[_statusIndex],
                  key: ValueKey(_statusIndex),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.65),
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
