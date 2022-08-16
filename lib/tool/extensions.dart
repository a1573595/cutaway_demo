import 'package:cutaway/router/route_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database/preferences.dart';

// TODO('更換APP寫法')
extension ContextGoRouterHelper on BuildContext {
  void goWithLogin(String location, {Object? extra}) {
    if (_isLogged()) {
      go(location, extra: extra);
    } else {
      push(AppPage.welcome.fullPath);
    }
  }

  void pushWithLogin(String location, {Object? extra}) {
    if (_isLogged()) {
      push(location, extra: extra);
    } else {
      push(AppPage.welcome.fullPath);
    }
  }

  void replaceWithLogin(String location, {Object? extra}) {
    if (_isLogged()) {
      replace(location, extra: extra);
    } else {
      push(AppPage.welcome.fullPath);
    }
  }
}

extension GoRouterHelper on GoRouter {
  void goWithLogin(String location, {Object? extra}) {
    if (_isLogged()) {
      go(location, extra: extra);
    } else {
      push(AppPage.welcome.fullPath);
    }
  }

  void pushWithLogin(String location, {Object? extra}) {
    if (_isLogged()) {
      push(location, extra: extra);
    } else {
      push(AppPage.welcome.fullPath);
    }
  }

  void replaceWithLogin(String location, {Object? extra}) {
    if (_isLogged()) {
      replace(location, extra: extra);
    } else {
      push(AppPage.welcome.fullPath);
    }
  }
}

bool _isLogged() {
  var box = Hive.box(tablePreferences);
  return box.get(keyIsLogin) == true;
}
