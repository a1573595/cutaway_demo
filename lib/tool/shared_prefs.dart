// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// final sharedPrefs = _SharedPrefs();
//
// const String _keyIsFirstEntry = "isFirstEntry";
// const String _keyIsBulletinBeenShown = "isBulletinBeenShown";
// const String _keyIsLogin = "isLogin";
//
// class _SharedPrefs {
//   final AndroidOptions _androidOptions = const AndroidOptions(
//     encryptedSharedPreferences: true,
//     // sharedPreferencesName: 'Test2',
//     // preferencesKeyPrefix: 'Test'
//   );
//
//   final IOSOptions _iOSOptions = const IOSOptions(
//       // accountName: _getAccountName(),
//       );
//
//   late final storage =
//       FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iOSOptions);
//
//   Future<bool> getIsFirstEntry() => read(_keyIsFirstEntry, false);
//
//   Future<void> setIsFirstEntry(bool value) => write(_keyIsFirstEntry, value);
//
//   Future<bool> getIsBulletinBeenShown() => read(_keyIsBulletinBeenShown, false);
//
//   Future<void> setIsBulletinBeenShown(bool value) =>
//       write(_keyIsBulletinBeenShown, value);
//
//   Future<bool> getIsLogin() => read(_keyIsLogin, false);
//
//   Future<void> setIsLogin(bool value) => write(_keyIsLogin, value);
//
//   Future<void> clear() => storage.deleteAll();
//
//   Future<T> read<T>(String key, T defaultValue) async {
//     final String? value = await storage.read(key: key);
//
//     if (value == null) {
//       return defaultValue;
//     } else if (T == bool) {
//       return (value == 'true') as T;
//     } else if (T == int) {
//       return int.parse(value) as T;
//     } else if (T == double) {
//       return double.parse(value) as T;
//     } else if (T == String) {
//       return value as T;
//     } else {
//       throw const FormatException(
//           'Unsupported data type, only support bool, iny, double and String.');
//     }
//   }
//
//   Future<void> write<T>(String key, T value) {
//     if (value is String) {
//       return storage.write(key: key, value: value);
//     } else if (value is bool || value is int || value is double) {
//       return storage.write(key: key, value: value.toString());
//     } else {
//       throw const FormatException(
//           'Unsupported data type, only support bool, iny, double and String.');
//     }
//   }
// }
