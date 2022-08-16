import 'package:hive_flutter/hive_flutter.dart';

part 'store_info.g.dart';

@HiveType(typeId: 3)
class StoreInfo {
  StoreInfo(
    this.id,
    this.imgUrl,
    this.title,
    this.description,
  );

  @HiveField(0)
  int id;

  @HiveField(1)
  String imgUrl;

  @HiveField(2)
  String title;

  @HiveField(3)
  String description;
}
