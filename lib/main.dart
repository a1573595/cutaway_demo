import 'package:cutaway/router/app_router.dart';
import 'package:cutaway/tool/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await sharedPrefs.init();

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
