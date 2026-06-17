import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

CustomTransitionPage fadeScaleTransitionPage({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 500),
  Curve curve = Curves.easeOutBack,
  double beginScale = 0.8,
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final scaleTween = Tween<double>(begin: beginScale, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: curve,
        ),
      );

      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: scaleTween,
          child: child,
        ),
      );
    },
  );
}