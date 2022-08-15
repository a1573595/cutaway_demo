// import 'package:cutaway/router/route_utils.dart';
// import 'package:cutaway/tool/shared_prefs.dart';
// import 'package:flutter/widgets.dart';
// import 'package:go_router/go_router.dart';
//
// // TODO('更換APP寫法')
// extension ContextGoRouterHelper on BuildContext {
//   void goWithLogin(String location, {Object? extra}) {
//     var isLogin = sharedPrefs.getIsLogin();
//
//     if (isLogin) {
//       go(location, extra: extra);
//     } else {
//       push(AppPage.welcome.fullPath);
//     }
//   }
//
//   void pushWithLogin(String location, {Object? extra}) {
//     var isLogin = sharedPrefs.getIsLogin();
//
//     if (isLogin) {
//       push(location, extra: extra);
//     } else {
//       push(AppPage.welcome.fullPath);
//     }
//   }
//
//   void replaceWithLogin(String location, {Object? extra}) {
//     var isLogin = sharedPrefs.getIsLogin();
//
//     if (isLogin) {
//       replace(location, extra: extra);
//     } else {
//       push(AppPage.welcome.fullPath);
//     }
//   }
// }
//
// extension GoRouterHelper on GoRouter {
//   void goWithLogin(String location, {Object? extra}) {
//     var isLogin = sharedPrefs.getIsLogin();
//
//     if (isLogin) {
//       go(location, extra: extra);
//     } else {
//       push(AppPage.welcome.fullPath);
//     }
//   }
//
//   void pushWithLogin(String location, {Object? extra}) {
//     var isLogin = sharedPrefs.getIsLogin();
//
//     if (isLogin) {
//       push(location, extra: extra);
//     } else {
//       push(AppPage.welcome.fullPath);
//     }
//   }
//
//   void replaceWithLogin(String location, {Object? extra}) {
//     var isLogin = sharedPrefs.getIsLogin();
//
//     if (isLogin) {
//       replace(location, extra: extra);
//     } else {
//       push(AppPage.welcome.fullPath);
//     }
//   }
// }
