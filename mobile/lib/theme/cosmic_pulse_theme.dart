import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CosmicPulse {
  const CosmicPulse._();

  // Core palette
  static const Color primary = Color(0xFF4648D4);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF6063EE);
  static const Color onPrimaryContainer = Color(0xFFFFFBFF);
  static const Color primaryFixed = Color(0xFFE1E0FF);
  static const Color primaryFixedDim = Color(0xFFC0C1FF);
  static const Color onPrimaryFixed = Color(0xFF07006C);
  static const Color onPrimaryFixedVariant = Color(0xFF2F2EBE);
  static const Color inversePrimary = Color(0xFFC0C1FF);

  static const Color secondary = Color(0xFFB90538);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFDC2C4F);
  static const Color onSecondaryContainer = Color(0xFFFFFBFF);
  static const Color secondaryFixed = Color(0xFFFFDADB);
  static const Color secondaryFixedDim = Color(0xFFFFB2B7);

  static const Color tertiary = Color(0xFF006C49);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF00885D);
  static const Color onTertiaryContainer = Color(0xFF000703);
  static const Color tertiaryFixed = Color(0xFF6FFBBE);
  static const Color tertiaryFixedDim = Color(0xFF4EDEA3);

  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color surface = Color(0xFFFAF8FF);
  static const Color surfaceDim = Color(0xFFD2D9F4);
  static const Color surfaceBright = Color(0xFFFAF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FF);
  static const Color surfaceContainer = Color(0xFFEAEDFF);
  static const Color surfaceContainerHigh = Color(0xFFE2E7FF);
  static const Color surfaceContainerHighest = Color(0xFFDAE2FD);

  static const Color onSurface = Color(0xFF131B2E);
  static const Color onSurfaceVariant = Color(0xFF464554);
  static const Color inverseSurface = Color(0xFF283044);
  static const Color inverseOnSurface = Color(0xFFEEF0FF);
  static const Color outline = Color(0xFF767586);
  static const Color outlineVariant = Color(0xFFC7C4D7);
  static const Color background = Color(0xFFFAF8FF);

  // Spacing — 4px baseline
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 48;
  static const double gutter = 24;

  // Radii
  static const Radius radiusSm = Radius.circular(4);
  static const Radius radiusMd = Radius.circular(12);
  static const Radius radiusLg = Radius.circular(16);
  static const Radius radiusXl = Radius.circular(24);
  static const Radius radiusXxl = Radius.circular(32);
  static const BorderRadius brSm = BorderRadius.all(radiusSm);
  static const BorderRadius brMd = BorderRadius.all(radiusMd);
  static const BorderRadius brLg = BorderRadius.all(radiusLg);
  static const BorderRadius brXl = BorderRadius.all(radiusXl);
  static const BorderRadius brXxl = BorderRadius.all(radiusXxl);

  // Gradient — 135° Electric Indigo
  static const LinearGradient supernovaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryContainer],
  );

  // Ambient shadows — indigo-tinted
  static List<BoxShadow> ambientShadow({double y = 4, double blur = 20, double opacity = 0.08}) => [
        BoxShadow(
          offset: Offset(0, y),
          blurRadius: blur,
          color: const Color(0xFF6366F1).withOpacity(opacity),
        ),
      ];

  static List<BoxShadow> primaryGlow({double blur = 12, double opacity = 0.4}) => [
        BoxShadow(
          blurRadius: blur,
          color: primary.withOpacity(opacity),
        ),
      ];
}

class SupernovaText {
  const SupernovaText._();

  static TextStyle headlineXl(Color c) => GoogleFonts.lato(
        fontSize: 40,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -0.02 * 40,
        color: c,
      );

  static TextStyle headlineLg(Color c) => GoogleFonts.lato(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.01 * 32,
        color: c,
      );

  static TextStyle headlineMd(Color c) => GoogleFonts.lato(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.3,
        color: c,
      );

  static TextStyle bodyLg(Color c) => GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: c,
      );

  static TextStyle bodyMd(Color c) => GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: c,
      );

  static TextStyle labelMd(Color c) => GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: 0.05 * 14,
        color: c,
      );

  static TextStyle labelSm(Color c) => GoogleFonts.lato(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: c,
      );
}

ThemeData buildCosmicPulseTheme() {
  const scheme = ColorScheme(
    brightness: Brightness.light,
    primary: CosmicPulse.primary,
    onPrimary: CosmicPulse.onPrimary,
    primaryContainer: CosmicPulse.primaryContainer,
    onPrimaryContainer: CosmicPulse.onPrimaryContainer,
    secondary: CosmicPulse.secondary,
    onSecondary: CosmicPulse.onSecondary,
    secondaryContainer: CosmicPulse.secondaryContainer,
    onSecondaryContainer: CosmicPulse.onSecondaryContainer,
    tertiary: CosmicPulse.tertiary,
    onTertiary: CosmicPulse.onTertiary,
    tertiaryContainer: CosmicPulse.tertiaryContainer,
    onTertiaryContainer: CosmicPulse.onTertiaryContainer,
    error: CosmicPulse.error,
    onError: CosmicPulse.onError,
    errorContainer: CosmicPulse.errorContainer,
    onErrorContainer: Color(0xFF93000A),
    surface: CosmicPulse.surface,
    onSurface: CosmicPulse.onSurface,
    surfaceContainerLowest: CosmicPulse.surfaceContainerLowest,
    surfaceContainerLow: CosmicPulse.surfaceContainerLow,
    surfaceContainer: CosmicPulse.surfaceContainer,
    surfaceContainerHigh: CosmicPulse.surfaceContainerHigh,
    surfaceContainerHighest: CosmicPulse.surfaceContainerHighest,
    surfaceDim: CosmicPulse.surfaceDim,
    surfaceBright: CosmicPulse.surfaceBright,
    onSurfaceVariant: CosmicPulse.onSurfaceVariant,
    outline: CosmicPulse.outline,
    outlineVariant: CosmicPulse.outlineVariant,
    inverseSurface: CosmicPulse.inverseSurface,
    onInverseSurface: CosmicPulse.inverseOnSurface,
    inversePrimary: CosmicPulse.inversePrimary,
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: CosmicPulse.background,
    splashFactory: InkSparkle.splashFactory,
  );

  return base.copyWith(
    textTheme: GoogleFonts.latoTextTheme(base.textTheme).apply(
      bodyColor: CosmicPulse.onSurface,
      displayColor: CosmicPulse.onSurface,
    ),
    iconTheme: const IconThemeData(color: CosmicPulse.onSurfaceVariant),
  );
}
