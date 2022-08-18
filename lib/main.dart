import 'dart:io';

import 'package:cutaway/database/preferences.dart';
import 'package:cutaway/router/app_router.dart';
import 'package:cutaway/tool/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:logger/src/outputs/file_output.dart';
import 'package:path_provider/path_provider.dart';

import 'database/table/notification_info.dart';
import 'database/table/promotion_info.dart';
import 'database/table/store_info.dart';
import 'database/table/topic_info.dart';

late Logger logger;

void main() async {
  // Hive.initFlutter()已經有了
  // WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive
    ..registerAdapter(NotificationInfoAdapter())
    ..registerAdapter(PromotionInfoAdapter())
    ..registerAdapter(TopicInfoAdapter())
    ..registerAdapter(StoreInfoAdapter());

  final Directory? directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();

  logger = Logger(
      printer: PrettyPrinter(printTime: true),
      output: MultiOutput([
        if (directory != null)
          FileOutput(
            file: File('${directory.path}/log.txt'),
          ),
        ConsoleOutput()
      ]));

  FlutterError.onError = (FlutterErrorDetails details) {
    logger.e('Error', details.exception, details.stack);
  };

  logger.i('Initialize the database');

  await Hive.openBox(tablePreferences);
  var notificationBox =
      await Hive.openBox<NotificationInfo>(tableNotificationInfo);
  var promotionBox = await Hive.openBox<PromotionInfo>(tablePromotionInfo);
  var topicBox = await Hive.openBox<TopicInfo>(tableTopicInfo);

  if (notificationBox.isEmpty) {
    notificationBox.addAll([
      NotificationInfo(
          0,
          '【通知】2022/05/29凌晨金流系統升級作業信用卡刷卡暫停服務資訊',
          '親愛的會員們，您好～\n\n2022/05/29 凌晨AM1:00至AM04:00因應銀行端金流系統升級作業，\n\n此時段暫停信用卡服務，還請見諒，請避開此時段新增訂單刷卡，感謝您的支持，謝謝。\n\nCutaway 卡個位 謝謝您',
          1652889600000),
      NotificationInfo(1, '【重要通知】Cutaway APP金流系統憑證升級更新！', '', 1641916800000),
      NotificationInfo(2, 'Cutaway卡個位 防疫公告', '', 1652803200000),
    ]);
  }

  if (promotionBox.isEmpty) {
    promotionBox.addAll([
      PromotionInfo(
          0, '🌟TGIF🌟週五想Chill一下這樣吃🍗', '下班先切一盤【東區鵝肉吳】其餘免談🥰', 1653580800000),
      PromotionInfo(
          1, '倒數一週！\$200優惠金現場領用︎🙆🏻‍♂️', '本週大雨特報☔在家吃火鍋喝湯剛剛好🤤', 1653408000000),
      PromotionInfo(2, '🍙嘿！別忘了帳戶還有\$200加菜金喔💰', '疫情下給辛苦的自己來點小獎勵！好心情就從美食開始吧！',
          1653321600000),
      PromotionInfo(3, '🥐週一不Blue！麵包早餐輕鬆做😍', '名店可頌吐司蓬鬆柔軟🍞早起不必看天氣～自然好心情💕',
          1653235200000),
    ]);
  }

  if (topicBox.isEmpty) {
    topicBox.addAll([
      TopicInfo('露營', 'Chill Chill 去露營', [
        StoreInfo(0, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(1, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(2, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(3, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(4, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      ]),
      TopicInfo('台北城', '台北城新店散策', [
        StoreInfo(0, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(1, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(2, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(3, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(4, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      ]),
      TopicInfo('米其林', '米其林必比登推介', [
        StoreInfo(0, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(1, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(2, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(3, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
        StoreInfo(4, Images.store1, '茅乃舍日本官方授權店', '茅乃舍與伊嚐特別企劃限定'),
      ]),
    ]);
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  logger.i('Start App');
  runApp(const ProviderScope(child: Cutaway()));
}

class Cutaway extends StatelessWidget {
  const Cutaway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
            routeInformationProvider: rootRouter.routeInformationProvider,
            routeInformationParser: rootRouter.routeInformationParser,
            routerDelegate: rootRouter.routerDelegate,
            title: 'Cutaway',
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFFFCFCFC),
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  centerTitle: true,
                  color: Colors.white,
                  titleTextStyle:
                      TextStyle(color: Colors.black, fontSize: 20.sp),
                  iconTheme: Theme.of(context).iconTheme),
              tabBarTheme: Theme.of(context).tabBarTheme.copyWith(),
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              // primaryColor: const Color(0xff26c6ed),
              // primaryIconTheme: const IconThemeData(color: Colors.black),
              // iconTheme: const IconThemeData(color: Colors.white)
              // appBarTheme: const AppBarTheme(
              //     iconTheme: IconThemeData(color: Colors.black))
            ),
          ));
}
