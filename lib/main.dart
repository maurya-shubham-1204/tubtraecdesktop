import 'package:flutter/material.dart';
import 'package:tubtrace_desktop/db/sqlite_setup.dart';
import 'package:tubtrace_desktop/screens/splash_screen.dart';
import 'package:tubtrace_desktop/theme/app_theme.dart';
import 'package:tubtrace_desktop/window_sizes.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupSqliteOpen();
  await AppThemeController.instance.load();
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: kSplashWindowSize,
    center: true,
    backgroundColor: Color(0xFF2B2B2B),
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    title: 'TubTrace',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    // Do NOT call setAsFrameless — it breaks restoring the Linux/GNOME title bar.
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    try {
      await windowManager.setIcon('assets/branding/app_icon.png');
    } catch (_) {}
    await windowManager.setResizable(false);
    await windowManager.setMinimumSize(kSplashWindowSize);
    await windowManager.setMaximumSize(kSplashWindowSize);
    await windowManager.setSize(kSplashWindowSize);
    await windowManager.center();
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const TubTraceDesktopApp());
}

class TubTraceDesktopApp extends StatelessWidget {
  const TubTraceDesktopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppThemeController.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'TubTrace',
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(AppThemeController.instance.seed),
          home: const SplashScreen(),
        );
      },
    );
  }
}
