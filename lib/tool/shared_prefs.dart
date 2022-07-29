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

  bool getIsFirstEntry() {
    return _sharedPrefs.getBool(_keyIsFirstEntry) ?? false;
  }

  Future<bool> setIsFirstEntry(bool value) async {
    return _sharedPrefs.setBool(_keyIsFirstEntry, value);
  }

  bool getIsBulletinBeenShown() {
    return _sharedPrefs.getBool(_keyIsBulletinBeenShown) ?? false;
  }

  Future<bool> setIsBulletinBeenShown(bool value) async {
    return _sharedPrefs.setBool(_keyIsBulletinBeenShown, value);
  }

  bool getIsLogin() {
    return _sharedPrefs.getBool(_keyIsLogin) ?? false;
  }

  Future<bool> setIsLogin(bool value) async {
    return _sharedPrefs.setBool(_keyIsLogin, value);
  }

  Future<bool> clear() async {
    return _sharedPrefs.clear();
  }
}
