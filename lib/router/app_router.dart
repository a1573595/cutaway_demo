import 'package:cutaway/router/route_utils.dart';
import 'package:go_router/go_router.dart';

import '../model/NotificationSummary.dart';
import '../page/first_guide/first_guide_page.dart';
import '../page/home/home_page.dart';
import '../page/home/notification/notification_detail_page.dart';
import '../page/home/notification/notification_page.dart';
import '../page/login/login_page.dart';
import '../page/login/register_page.dart';
import '../page/login/welcome_page.dart';
import 'fade_transition_page.dart';

final firstGuideRouter = GoRoute(
  name: AppPage.firstGuide.name,
  path: AppPage.firstGuide.fullPath,
  builder: (context, state) => FirstGuidePage(),
);

final homeRouter = GoRoute(
    name: AppPage.home.name,
    path: AppPage.home.fullPath,
    // builder: (context, state) => HomePage(),
    pageBuilder: (context, state) =>
        buildPageWithDefaultTransition(state, HomePage()),
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
                builder: (context, state) =>
                    NotificationDetailPage(state.extra as NotificationSummary)),
          ]),
    ]);

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
    ]);
