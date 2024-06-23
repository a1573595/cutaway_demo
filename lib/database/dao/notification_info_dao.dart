import 'package:cutaway/database/table/notification_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
}
