import 'package:flutter/material.dart';
import 'package:screen_retriever/screen_retriever.dart';
import 'package:tubtrace_desktop/window_sizes.dart';
import 'package:window_manager/window_manager.dart';

/// Compact card (splash / unlock). Hides previous frame, then shows a new
/// centered card so the user never sees a resize animation.
Future<void> openCardWindow({
  Size size = kCardWindowSize,
}) async {
  await windowManager.hide();
  await Future<void>.delayed(const Duration(milliseconds: 40));

  if (await windowManager.isMaximized()) {
    await windowManager.unmaximize();
  }

  await windowManager.setResizable(false);
  await windowManager.setTitleBarStyle(
    TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  await windowManager.setMinimumSize(size);
  await windowManager.setMaximumSize(size);
  await windowManager.setSize(size);
  await windowManager.setTitle('TubTrace');
  await windowManager.center();

  await windowManager.show();
  await windowManager.focus();
}

Future<void> openSetupCardWindow({Size size = kSetupCardWindowSize}) {
  return openCardWindow(size: size);
}

/// Open main desktop as a **fresh full-screen window**:
/// hide lock card → prepare exact screen bounds while hidden → show maximized.
/// Avoids the visible “enlarge old window” effect.
Future<void> openMainWindow() async {
  await windowManager.hide();
  await Future<void>.delayed(const Duration(milliseconds: 60));

  if (await windowManager.isMaximized()) {
    await windowManager.unmaximize();
  }

  await windowManager.setMaximumSize(const Size(100000, 100000));
  await windowManager.setMinimumSize(kMainMinWindowSize);
  await windowManager.setResizable(true);
  await windowManager.setTitleBarStyle(
    TitleBarStyle.normal,
    windowButtonVisibility: true,
  );
  await windowManager.setTitle('TubTrace');

  final bounds = await _fullscreenBounds();
  await windowManager.setSize(bounds.size);
  await windowManager.setPosition(bounds.topLeft);

  // Maximize while still hidden when possible, then reveal.
  try {
    await windowManager.maximize();
  } catch (_) {}

  await Future<void>.delayed(const Duration(milliseconds: 40));
  await windowManager.show();
  await windowManager.focus();

  // Ensure maximized after show (some Linux WMs ignore maximize-while-hidden).
  if (!await windowManager.isMaximized()) {
    await windowManager.maximize();
  }
}

Future<({Size size, Offset topLeft})> _fullscreenBounds() async {
  try {
    final display = await screenRetriever.getPrimaryDisplay();
    final size = display.visibleSize ?? display.size;
    final topLeft = display.visiblePosition ?? Offset.zero;
    return (size: size, topLeft: topLeft);
  } catch (_) {
    return (size: kMainWindowSize, topLeft: Offset.zero);
  }
}
