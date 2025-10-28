import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/constants.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  bool get getDeviceFirstOpen {
    return _prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_OPEN) ?? false;
  }

  ThemeMode? get getThemeMode {
    final themeMode = _prefs.getString(AppConstants.STORAGE_THEME_MODE);
    switch (themeMode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }

  String? get getLocalization {
    return _prefs.getString(AppConstants.STORAGE_LOCALIZATION);
  }

  String? get getIsLoggedIn {
    return _prefs.getString(AppConstants.STORAGE_USER_UID);
  }

  int? get getSelectedPageIndex {
    return _prefs.getInt(AppConstants.STORAGE_NAVIGATION_INDEX);
  }

  // UserItem? get getUserProfile {
  //   final profileOffline =
  //       _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
  //   if (profileOffline.isNotEmpty) {
  //     return UserItem.fromJson(jsonDecode(profileOffline));
  //   }
  //   return null;
  // }

  String get getUserToken {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
