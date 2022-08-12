import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefs = _SharedPrefs();

const String _keyIsFirstEntry = "isFirstEntry";
const String _keyIsBulletinBeenShown = "isBulletinBeenShown";
const String _keyIsLogin = "isLogin";

class _SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  bool getIsFirstEntry() => read(_keyIsFirstEntry, false);

  Future<bool> setIsFirstEntry(bool value) => write(_keyIsFirstEntry, value);

  bool getIsBulletinBeenShown() => read(_keyIsBulletinBeenShown, false);

  Future<bool> setIsBulletinBeenShown(bool value) =>
      write(_keyIsBulletinBeenShown, value);

  bool getIsLogin() => read(_keyIsLogin, false);

  Future<bool> setIsLogin(bool value) => write(_keyIsLogin, value);

  Future<bool> clear() => _sharedPrefs.clear();

  Future<bool> write<T>(String key, T value) {
    if (value is String) {
      return _sharedPrefs.setString(key, (value).toBase64());
    } else if (value is bool || value is int || value is double) {
      return _sharedPrefs.setString(key, value.toString().toBase64());
    } else {
      throw Exception(
          'Unsupported data type, only support String, double, int and bool.');
    }
  }

  T read<T>(String key, T defaultValue) {
    var encryptStr = _sharedPrefs.getString(key);
    var decryptStr = encryptStr?.fromBase64();

    if (decryptStr == null) {
      return defaultValue;
    } else if (T == String) {
      return decryptStr as T;
    } else if (T == double) {
      return double.parse(decryptStr) as T;
    } else if (T == int) {
      return int.parse(decryptStr) as T;
    } else if (T == bool) {
      return (decryptStr == 'true') as T;
    }

    throw Exception('Unknown exception');
  }
}

extension on String {
  toBase64() {
    var bytes = utf8.encode(this);
    return base64.encode(bytes);
  }

  String fromBase64() {
    var bytes = base64.decode(this);
    return utf8.decode(bytes);
  }
}
