import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Dark "night circuit" palette built from the Ojra rider app brand colors
/// (burgundy / magenta / amber) but tuned for a unique, non-template look.
class OjraColors {
  OjraColors._();

  static const bg = Color(0xFF120810); // page background (near-black burgundy)
  static const bgElevated = Color(0xFF1A0C13);
  static const surface = Color(0xFF211019); // cards
  static const surfaceBorder = Color(0xFF3A1D2E);

  static const primary = Color(0xFFD81B60); // magenta
  static const primaryBright = Color(0xFFF06292);
  static const burgundy = Color(0xFF880E4F);
  static const burgundyDeep = Color(0xFF4A0B2C);

  static const amber = Color(0xFFFFB300);
  static const amberSoft = Color(0xFFFFE1A6);

  static const textPrimary = Color(0xFFF7EFF3);
  static const textSecondary = Color(0xFFC9A6B8);
  static const textMuted = Color(0xFF8A6678);

  static const trace = Color(0xFF4A2838); // dim circuit trace
  static const traceBright = Color(0xFF6A3A52); // pads / nodes
  static const white = Color(0xFFFFFFFF);

  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A0B2C), Color(0xFF880E4F), Color(0xFFD81B60)],
  );

  static const neonGradient = LinearGradient(
    colors: [Color(0xFFF06292), Color(0xFFFFB300)],
  );
}

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: OjraColors.burgundy,
    brightness: Brightness.dark,
    primary: OjraColors.primary,
    secondary: OjraColors.amber,
    surface: OjraColors.surface,
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: OjraColors.bg,
    canvasColor: OjraColors.bg,
  );

  final textTheme = GoogleFonts.cairoTextTheme(base.textTheme).apply(
    bodyColor: OjraColors.textPrimary,
    displayColor: OjraColors.textPrimary,
  );

  return base.copyWith(
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: OjraColors.bg,
      foregroundColor: OjraColors.textPrimary,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: OjraColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: OjraColors.textPrimary,
        minimumSize: const Size(0, 52),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        side: const BorderSide(color: OjraColors.surfaceBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
    dividerTheme: const DividerThemeData(color: OjraColors.surfaceBorder, thickness: 1, space: 1),
    iconTheme: const IconThemeData(color: OjraColors.textPrimary),
    cardTheme: CardThemeData(
      color: OjraColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}

/// Font used for Amazigh (Tifinagh) text.
TextStyle tifinaghStyle({double? fontSize, FontWeight fontWeight = FontWeight.w500, Color? color}) {
  return GoogleFonts.notoSansTifinagh(fontSize: fontSize, fontWeight: fontWeight, color: color);
}
