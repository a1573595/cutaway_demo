import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../model/NotificationSummary.dart';
import '../../../model/PromotionSummary.dart';
import '../../../router/route_utils.dart';

part 'notification_view_model.dart';

class NotificationPage extends ConsumerWidget {
  NotificationPage({Key? key}) : super(key: key);

  final List<NotificationSummary> notificationList = [
    NotificationSummary(
        0,
        '【通知】2022/05/29凌晨金流系統升級作業信用卡刷卡暫停服務資訊',
        '親愛的會員們，您好～\n\n2022/05/29 凌晨AM1:00至AM04:00因應銀行端金流系統升級作業，\n\n此時段暫停信用卡服務，還請見諒，請避開此時段新增訂單刷卡，感謝您的支持，謝謝。\n\nCutaway 卡個位 謝謝您',
        1652889600000),
    NotificationSummary(1, '【重要通知】Cutaway APP金流系統憑證升級更新！', '', 1641916800000),
    NotificationSummary(2, 'Cutaway卡個位 防疫公告', '', 1652803200000),
  ];

  final List<PromotionSummary> promotionList = [
    PromotionSummary(
        0, '🌟TGIF🌟週五想Chill一下這樣吃🍗', '下班先切一盤【東區鵝肉吳】其餘免談🥰', 1653580800000),
    PromotionSummary(
        1, '倒數一週！\$200優惠金現場領用︎🙆🏻‍♂️', '本週大雨特報☔在家吃火鍋喝湯剛剛好🤤', 1653408000000),
    PromotionSummary(2, '🍙嘿！別忘了帳戶還有\$200加菜金喔💰', '疫情下給辛苦的自己來點小獎勵！好心情就從美食開始吧！',
        1653321600000),
    PromotionSummary(
        3, '🥐週一不Blue！麵包早餐輕鬆做😍', '名店可頌吐司蓬鬆柔軟🍞早起不必看天氣～自然好心情💕', 1653235200000),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          '通知中心',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: Consumer(builder: (context, ref, _) {
                    var page = ref.watch(_pagePosition.state).state;
                    var color = page == 0 ? Colors.yellow[100] : Colors.white;

                    return TextButton(
                      onPressed: () => ref.read(_pagePosition.state).state = 0,
                      style: TextButton.styleFrom(
                          backgroundColor: color,
                          side: const BorderSide(color: Colors.grey),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      child: const Center(
                          child: Text(
                        '最新消息',
                        style: TextStyle(color: Colors.black),
                      )),
                    );
                  }),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: Consumer(builder: (context, ref, _) {
                    var page = ref.watch(_pagePosition.state).state;
                    var color = page == 1 ? Colors.yellow[100] : Colors.white;

                    return TextButton(
                      onPressed: () => ref.read(_pagePosition.state).state = 1,
                      style: TextButton.styleFrom(
                          backgroundColor: color,
                          side: const BorderSide(color: Colors.grey),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)))),
                      child: const Center(
                          child: Text('卡編專區',
                              style: TextStyle(color: Colors.black))),
                    );
                  }),
                ),
              ],
            ),
            const Divider(color: Colors.black),
            Expanded(
              child: Consumer(builder: (context, ref, _) {
                var page = ref.watch(_pagePosition.state).state;
                if (page == 0) {
                  return ListView.builder(
                      itemCount: notificationList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemNotification(notificationList[index]);
                      });
                } else {
                  return ListView.builder(
                      itemCount: promotionList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemPromotion(promotionList[index]);
                      });
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}

class ItemNotification extends StatelessWidget {
  const ItemNotification(this._notificationSummary, {Key? key})
      : super(key: key);

  final NotificationSummary _notificationSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          var router = GoRouter.of(context);
          router.go('${router.location}${AppPage.notificationDetail.fullPath}',
              extra: _notificationSummary);
        },
        child: Ink(
          height: 80.sp,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(4.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_notificationSummary.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black)),
                Expanded(child: Container()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(_getDateString(_notificationSummary.timeMillis),
                      style: const TextStyle(color: Colors.black)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDateString(int timeMillis) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeMillis);
    return '${date.year}-${date.month}-${date.day}';
  }
}

class ItemPromotion extends StatelessWidget {
  const ItemPromotion(this._promotionSummary, {Key? key}) : super(key: key);

  final PromotionSummary _promotionSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => Navigator.of(context),
        child: Ink(
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(4.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_promotionSummary.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black)),
                Text(_promotionSummary.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black)),
                Expanded(child: Container()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(_getDateString(_promotionSummary.timeMillis),
                      style: const TextStyle(color: Colors.black)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDateString(int timeMillis) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeMillis);
    return '${date.year}-${date.month}-${date.day}';
  }
}
