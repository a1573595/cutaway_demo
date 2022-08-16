import 'package:hive_flutter/hive_flutter.dart';

part 'promotion_info.g.dart';

const String tablePromotionInfo = "promotionInfo";

@HiveType(typeId: 1)
class PromotionInfo extends HiveObject {
  PromotionInfo(
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
