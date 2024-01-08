import 'package:cutaway/database/preferences.dart';
import 'package:cutaway/database/table/notification_info.dart';
import 'package:cutaway/page/first_guide/first_guide_page.dart';
import 'package:cutaway/page/home/home_page.dart';
import 'package:cutaway/page/home/notification/notification_detail_page.dart';
import 'package:cutaway/page/home/notification/notification_page.dart';
import 'package:cutaway/page/login/login_page.dart';
import 'package:cutaway/page/login/register_page.dart';
import 'package:cutaway/page/login/welcome_page.dart';
import 'package:cutaway/router/fade_transition_page.dart';
import 'package:cutaway/router/route_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

final rootRouter = GoRouter(
  initialLocation:
      Hive.box(tablePreferences).get(keyIsFirstEntry) == true ? AppPage.home.fullPath : AppPage.firstGuide.fullPath,
  routes: [
    firstGuideRouter,
    homeRouter,
    loginRouter,
  ],
);

final firstGuideRouter = GoRoute(
  name: AppPage.firstGuide.name,
  path: AppPage.firstGuide.fullPath,
  builder: (context, state) => FirstGuidePage(),
);

final homeRouter = GoRoute(
  name: AppPage.home.name,
  path: AppPage.home.fullPath,
  pageBuilder: (context, state) => buildPageWithDefaultTransition(state, const HomePage()),
  routes: [
    GoRoute(
      name: AppPage.notification.name,
      path: AppPage.notification.path,
      // path: 'notification',
      builder: (context, state) => NotificationPage(),
      routes: [
        GoRoute(
          name: AppPage.notificationDetail.name,
          path: AppPage.notificationDetail.path,
          builder: (context, state) => NotificationDetailPage(state.extra as NotificationInfo),
        ),
      ],
    ),
  ],
);

final loginRouter = GoRoute(
  name: AppPage.welcome.name,
  path: AppPage.welcome.fullPath,
  builder: (context, state) => const WelcomePage(),
  routes: [
    GoRoute(
      name: AppPage.login.name,
      path: AppPage.login.path,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: AppPage.register.name,
      path: AppPage.register.path,
      builder: (context, state) => const RegisterPage(),
    ),
  ],
);
