import 'package:hive_flutter/hive_flutter.dart';

part 'notification_info.g.dart';

const String tableNotificationInfo = "notificationInfo";

@HiveType(typeId: 0)
class NotificationInfo extends HiveObject {
  NotificationInfo(
    this.id,
    this.title,
    this.description,
    this.sentTime,
  );

  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  int sentTime;
}
