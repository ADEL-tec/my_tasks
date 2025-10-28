import 'package:flutter/material.dart';

class TColor {
  // const TColor._();

  // static const Color primary = Color(0xFF1C2C4C);      // Navy Blue
  // static const Color secondary = Color(0xFFF5C7A9);    // Peach
  // static const Color accent = Color(0xFFD95C45);       // Red Clay
  // static const Color lightBackground = Color(0xFFFAFAFA);
  // static const Color textPrimary = Color(0xFF1F1F1F);
  // static const Color textSecondary = Color(0xFF777777);
  // static const Color success = Color(0xFF3EB489);
  // static const Color error = Color(0xFFD9534F);

  // // Optional: for dark theme backgrounds
  // static const Color darkBackground = Color(0xFF121212);
  // static const Color darkSurface = Color(0xFF2C2C2C);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff904b3b),
      surfaceTint: Color(0xff904b3b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdad2),
      onPrimaryContainer: Color(0xff733426),
      secondary: Color(0xff39608f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd3e4ff),
      onSecondaryContainer: Color(0xff1d4875),
      tertiary: Color(0xff29638a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcbe6ff),
      onTertiaryContainer: Color(0xff004b71),
      error: Color(0xff904a44),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff73332e),
      surface: Color(0xfff5fafb),
      onSurface: Color(0xff171d1e),
      onSurfaceVariant: Color(0xff3f484a),
      outline: Color(0xff6f797a),
      outlineVariant: Color(0xffbfc8ca),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3133),
      inversePrimary: Color(0xffffb4a3),
      primaryFixed: Color(0xffffdad2),
      onPrimaryFixed: Color(0xff3a0a02),
      primaryFixedDim: Color(0xffffb4a3),
      onPrimaryFixedVariant: Color(0xff733426),
      secondaryFixed: Color(0xffd3e4ff),
      onSecondaryFixed: Color(0xff001c38),
      secondaryFixedDim: Color(0xffa3c9fe),
      onSecondaryFixedVariant: Color(0xff1d4875),
      tertiaryFixed: Color(0xffcbe6ff),
      onTertiaryFixed: Color(0xff001e30),
      tertiaryFixedDim: Color(0xff97ccf8),
      onTertiaryFixedVariant: Color(0xff004b71),
      surfaceDim: Color(0xffd5dbdc),
      surfaceBright: Color(0xfff5fafb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f6),
      surfaceContainer: Color(0xffe9eff0),
      surfaceContainerHigh: Color(0xffe3e9ea),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb4a3),
      surfaceTint: Color(0xffffb4a3),
      onPrimary: Color(0xff561f12),
      primaryContainer: Color(0xff733426),
      onPrimaryContainer: Color(0xffffdad2),
      secondary: Color(0xffa3c9fe),
      onSecondary: Color(0xff00315b),
      secondaryContainer: Color(0xff1d4875),
      onSecondaryContainer: Color(0xffd3e4ff),
      tertiary: Color(0xff97ccf8),
      onTertiary: Color(0xff00344f),
      tertiaryContainer: Color(0xff004b71),
      onTertiaryContainer: Color(0xffcbe6ff),
      error: Color(0xffffb4ac),
      onError: Color(0xff561e1a),
      errorContainer: Color(0xff73332e),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1415),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8ca),
      outline: Color(0xff899294),
      outlineVariant: Color(0xff3f484a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff904b3b),
      primaryFixed: Color(0xffffdad2),
      onPrimaryFixed: Color(0xff3a0a02),
      primaryFixedDim: Color(0xffffb4a3),
      onPrimaryFixedVariant: Color(0xff733426),
      secondaryFixed: Color(0xffd3e4ff),
      onSecondaryFixed: Color(0xff001c38),
      secondaryFixedDim: Color(0xffa3c9fe),
      onSecondaryFixedVariant: Color(0xff1d4875),
      tertiaryFixed: Color(0xffcbe6ff),
      onTertiaryFixed: Color(0xff001e30),
      tertiaryFixedDim: Color(0xff97ccf8),
      onTertiaryFixedVariant: Color(0xff004b71),
      surfaceDim: Color(0xff0e1415),
      surfaceBright: Color(0xff343a3b),
      surfaceContainerLowest: Color(0xff090f10),
      surfaceContainerLow: Color(0xff171d1e),
      surfaceContainer: Color(0xff1b2122),
      surfaceContainerHigh: Color(0xff252b2c),
      surfaceContainerHighest: Color(0xff303637),
    );
  }
}
