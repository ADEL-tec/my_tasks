import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../core/values/constants.dart';

import '../../global.dart';

part 'theme_mode_state.dart';

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit()
    : super(
        ThemeModeState(Global.storageService.getThemeMode ?? ThemeMode.dark),
      ) {
    _loadTheme();
  }

  // Load saved theme mode from SharedPreferences
  Future<void> _loadTheme() async {
    if (Global.storageService.getThemeMode == null) {
      emit(ThemeModeState(ThemeMode.system));
      Global.storageService.setString(
        AppConstants.STORAGE_THEME_MODE,
        ThemeMode.system.name,
      );
    } else {
      emit(ThemeModeState(Global.storageService.getThemeMode!));
    }
  }

  // Change theme mode
  Future<void> setTheme(ThemeMode mode) async {
    print(Global.storageService.getThemeMode);

    emit(ThemeModeState(mode));
    print("state=> ${state.themeMode}");

    Global.storageService.setString(AppConstants.STORAGE_THEME_MODE, mode.name);
  }
}
