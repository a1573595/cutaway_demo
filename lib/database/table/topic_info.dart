import 'package:cutaway/database/table/store_info.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'topic_info.g.dart';

const String tableTopicInfo = "topicInfo";

@HiveType(typeId: 2)
class TopicInfo extends HiveObject {
  TopicInfo(
    this.keyword,
    this.title,
    this.storeInfoList,
  );

  @HiveField(0)
  String keyword;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<StoreInfo> storeInfoList;
}
