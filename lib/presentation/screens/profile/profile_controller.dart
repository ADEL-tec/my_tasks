import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extensions/context_extensions.dart';

import '../../../core/routes/names.dart';
import '../../../logic/auth_bloc/auth_bloc.dart';
import '../../../logic/localization_bloc/localization_bloc.dart';
import '../../../logic/navigation_cubit/navigation_cubit.dart';
import '../../../logic/theme_mode_cubit/theme_mode_cubit.dart';

class ProfileController {
  static String getLanguageName(BuildContext context, String langCode) {
    final loc = context.localization;
    switch (langCode) {
      case 'en':
        return loc.language_en;
      case 'ar':
        return loc.language_ar;
      default:
        return langCode;
    }
  }

  static String getThemeModeName(BuildContext context, String themeMode) {
    if (context.localization.localeName == "en") {
      return themeMode[0].toUpperCase() + themeMode.substring(1);
    } else {
      switch (themeMode) {
        case 'dark':
          return context.localization.dark;
        case 'light':
          return context.localization.light;
        case 'system':
          return context.localization.system;
        default:
          return context.localization.system;
      }
    }
  }

  static IconData getThemeModeIcon(String value) {
    switch (value) {
      case 'dark':
        return Icons.dark_mode;
      case 'light':
        return Icons.light_mode;
      case 'system':
        return Icons.brightness_auto;
      default:
        return Icons.settings;
    }
  }

  static void onThemeModeChange(BuildContext context, String? newValue) {
    context.read<ThemeModeCubit>().setTheme(ThemeMode.values.byName(newValue!));
  }

  static void onLanguageChange(BuildContext context, String? newLang) {
    if (newLang == 'ar') {
      context.read<LocalizationBloc>().add(OnLocalizationArabicEvent());
    } else {
      context.read<LocalizationBloc>().add(OnLocalizationEnglishEvent());
    }
  }

  static void onLogout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutRequested());
    context.read<NavigationCubit>().setPageIndex(0);

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      ModalRoute.withName('/'),
    );
  }
}
