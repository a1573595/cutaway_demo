import 'store_summary.dart';

class TopicSummary {
  String keyword;
  String title;
  List<StoreSummary> storeSummaries;

  TopicSummary(
    this.keyword,
    this.title,
    this.storeSummaries,
  );
}
