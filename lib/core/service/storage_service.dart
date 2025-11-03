import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tasks/domain/entities/user_entity.dart';
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

  Future<bool> setMap(String key, Map<String, dynamic> value) async {
    final encoded = jsonEncode(_convertTimestamps(value));
    return await _prefs.setString(key, encoded);
  }

  Map<String, dynamic> _convertTimestamps(Map<String, dynamic> map) {
    final result = <String, dynamic>{};
    map.forEach((key, val) {
      if (val is Timestamp) {
        result[key] = val.toDate().toIso8601String();
      } else if (val is Map) {
        result[key] = _convertTimestamps(Map<String, dynamic>.from(val));
      } else {
        result[key] = val;
      }
    });
    return result;
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

  UserEntity get getUserData {
    print(
      "display___ ${_prefs.getString(AppConstants.STORAGE_USER_DATA) ?? "{}"}",
    );
    return UserEntity.fromJson(
      _prefs.getString(AppConstants.STORAGE_USER_DATA) ?? "{}",
    );
  }

  String get getUserToken {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
