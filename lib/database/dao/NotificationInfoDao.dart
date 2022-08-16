import 'package:hive_flutter/hive_flutter.dart';

import '../table/notification_info.dart';

class NotificationDao {
  void insert(NotificationInfo info) {
    final box = Hive.box<NotificationInfo>(tableNotificationInfo);
    box.add(info);
  }

  void insertAll(List<NotificationInfo> infoList) {
    final box = Hive.box<NotificationInfo>(tableNotificationInfo);
    box.addAll(infoList);
  }

  void update(NotificationInfo info) {
    final box = Hive.box<NotificationInfo>(tableNotificationInfo);
    box.put(info.key, info);
  }

  void delete(NotificationInfo info) {
    final box = Hive.box<NotificationInfo>('user_box');
    box.delete(info);
  }

  NotificationInfo? get(String key) {
    final box = Hive.box<NotificationInfo>(tableNotificationInfo);
    final info = box.get(key);
    return info;
  }

  List<NotificationInfo> getAll() {
    final box = Hive.box<NotificationInfo>(tableNotificationInfo);
    final infoList = box.values.toList();
    return infoList;
  }

// Future<void> insert(NotificationInfo info) async {
//   final box = await Hive.openBox<NotificationInfo>(tableNotificationInfo);
//   box.add(info);
//   await box.close();
// }
//
// Future<void> insertAll(List<NotificationInfo> infoList) async {
//   final box = await Hive.openBox<NotificationInfo>(tableNotificationInfo);
//   box.addAll(infoList);
//   await box.close();
// }
//
// Future<void> update(NotificationInfo info) async {
//   final box = await Hive.openBox<NotificationInfo>(tableNotificationInfo);
//   box.put(info.key, info);
//   await box.close();
// }
//
// Future<void> delete(NotificationInfo info) async {
//   final box = await Hive.openBox<NotificationInfo>('user_box');
//   box.delete(info);
//   await box.close();
// }
//
// Future<NotificationInfo?> get(String key) async {
//   final box = await Hive.openBox<NotificationInfo>(tableNotificationInfo);
//   final info = box.get(key);
//   await box.close();
//   return info;
// }
//
// Future<List<NotificationInfo>> getAll() async {
//   final box = await Hive.openBox<NotificationInfo>(tableNotificationInfo);
//   final infoList = box.values.toList();
//   await box.close();
//   return infoList;
// }
}
