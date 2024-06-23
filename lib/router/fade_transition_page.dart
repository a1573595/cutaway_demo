import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class FadeTransitionPage extends CustomTransitionPage {
  FadeTransitionPage({
    required super.key,
    required super.child,
  }) : super(
            transitionsBuilder: (c, animation, a2, child) => FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ));

  static final _curveTween = CurveTween(curve: Curves.easeIn);
}

CustomTransitionPage buildPageWithDefaultTransition(
  GoRouterState state,
  Widget child,
) {
  return FadeTransitionPage(
    key: state.pageKey,
    child: child,
  );
}
