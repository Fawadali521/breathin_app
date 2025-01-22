// ignore_for_file: avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  ///
  /// List of const keys
  ///
  static const String onboardingKey = 'onBoardingCount';

  ///
  /// Setters and getters
  ///
  bool get onBoardingPage => _getFromDisk(onboardingKey) ?? false;
  set onBoardingPage(bool count) => _saveToDisk(onboardingKey, count);

  ///
  ///initializing instance
  ///
  init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    print(
        '(TRACE =>) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T? content) {
    print(
        '(TRACE =>) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }

    if (content == null) {
      _preferences!.remove(key);
    }
  }
}
