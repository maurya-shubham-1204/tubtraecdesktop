import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Preset accent colors for Settings → Theme.
class ThemePresets {
  static const List<(String, Color)> all = [
    ('Teal', Color(0xFF0F766E)),
    ('Blue', Color(0xFF0284C7)),
    ('Indigo', Color(0xFF4338CA)),
    ('Green', Color(0xFF15803D)),
    ('Rose', Color(0xFFE11D48)),
    ('Amber', Color(0xFFD97706)),
    ('Slate', Color(0xFF334155)),
  ];

  static const Color defaultSeed = Color(0xFF0F766E);
}

class AppThemeController extends ChangeNotifier {
  AppThemeController._();
  static final AppThemeController instance = AppThemeController._();

  static const _prefsKey = 'theme_seed_argb';

  Color _seed = ThemePresets.defaultSeed;
  Color get seed => _seed;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getInt(_prefsKey);
      if (raw != null) {
        _seed = Color(raw);
      }
    } catch (_) {}
    AppColors.applySeed(_seed);
    notifyListeners();
  }

  Future<void> setSeed(Color color) async {
    _seed = color;
    AppColors.applySeed(color);
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_prefsKey, color.toARGB32());
    } catch (_) {}
  }
}

/// Soft medical palette. Accent / sidebar colors follow [AppThemeController].
class AppColors {
  static Color splashBg = const Color(0xFF152028);
  static Color splashAccent = ThemePresets.defaultSeed;
  static Color splashProgress = const Color(0xFF14B8A6);
  static Color sidebarBg = const Color(0xFF0F1C24);
  static Color sidebarActive = ThemePresets.defaultSeed;
  static Color pageBg = const Color(0xFFF3F6F8);
  static const Color cardBg = Colors.white;
  static const Color muted = Color(0xFF64748B);
  static const Color text = Color(0xFF0F172A);
  static const Color success = Color(0xFF059669);
  static const Color purple = Color(0xFF5B8DEF);
  static const Color green = Color(0xFF2DD4BF);
  static const Color red = Color(0xFFE11D48);
  static const Color blue = Color(0xFF0284C7);
  static const Color amber = Color(0xFFD97706);
  static const Color border = Color(0xFFDDE5EB);
  static Color softTeal = const Color(0xFFE6F7F5);
  static const Color headerWash = Color(0xFFF8FBFC);

  static void applySeed(Color seed) {
    splashAccent = seed;
    sidebarActive = seed;
    splashProgress = Color.lerp(seed, Colors.white, 0.28) ?? seed;
    softTeal = Color.lerp(seed, Colors.white, 0.90) ?? const Color(0xFFE6F7F5);
    // Keep splash/sidebar dark shells; tint slightly toward seed.
    splashBg = Color.lerp(const Color(0xFF152028), seed, 0.12) ?? const Color(0xFF152028);
    sidebarBg = Color.lerp(const Color(0xFF0F1C24), seed, 0.10) ?? const Color(0xFF0F1C24);
  }
}

ThemeData buildAppTheme([Color? seed]) {
  final accent = seed ?? AppColors.splashAccent;
  final base = ColorScheme.fromSeed(
    seedColor: accent,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: base.copyWith(
      primary: accent,
      secondary: AppColors.blue,
      error: AppColors.red,
      surface: AppColors.cardBg,
    ),
    scaffoldBackgroundColor: AppColors.pageBg,
    dividerColor: AppColors.border,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.text,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBg,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: accent, width: 1.5),
      ),
    ),
    dataTableTheme: DataTableThemeData(
      headingRowColor: WidgetStateProperty.all(AppColors.headerWash),
      headingTextStyle: const TextStyle(
        color: AppColors.muted,
        fontWeight: FontWeight.w700,
        fontSize: 12,
        letterSpacing: 0.2,
      ),
      dataTextStyle: const TextStyle(color: AppColors.text, fontSize: 13),
      dividerThickness: 0.6,
      headingRowHeight: 44,
      dataRowMinHeight: 48,
      dataRowMaxHeight: 56,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.text,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: accent),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) return Colors.white;
        return AppColors.muted;
      }),
      trackColor: WidgetStateProperty.resolveWith((s) {
        if (s.contains(WidgetState.selected)) return accent;
        return AppColors.border;
      }),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.text, height: 1.35),
      titleMedium: TextStyle(color: AppColors.text, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: AppColors.text, fontWeight: FontWeight.w700),
    ),
  );
}
