import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../database/table/notification_info.dart';
import '../../../database/table/promotion_info.dart';
import '../../../router/route_utils.dart';

part 'notification_view_model.dart';

class NotificationPage extends ConsumerWidget {
  NotificationPage({Key? key}) : super(key: key);

  final List<NotificationInfo> notificationList =
      Hive.box<NotificationInfo>(tableNotificationInfo).values.toList();

  final List<PromotionInfo> promotionList =
      Hive.box<PromotionInfo>(tablePromotionInfo).values.toList();

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
  const ItemNotification(this._info, {Key? key}) : super(key: key);

  final NotificationInfo _info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          var router = GoRouter.of(context);
          router.go('${router.location}${AppPage.notificationDetail.fullPath}',
              extra: _info);
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
                Text(_info.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black)),
                Expanded(child: Container()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(_getDateString(_info.sentTime),
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
  const ItemPromotion(this._info, {Key? key}) : super(key: key);

  final PromotionInfo _info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => Navigator.of(context),
        child: Ink(
          height: 100.sp,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(4.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_info.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black)),
                Text(_info.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black)),
                Expanded(child: Container()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(_getDateString(_info.sentTime),
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
