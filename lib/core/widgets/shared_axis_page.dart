import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:j_donuts/app/motion/app_motion.dart';

class SharedAxisPage<T> extends CustomTransitionPage<T> {
  SharedAxisPage({
    required BuildContext context,
    required super.child,
    super.key,
    super.name,
  }) : super(
         transitionDuration: AppMotion.scaled(context, AppDurations.slow),
         reverseTransitionDuration: AppMotion.scaled(
           context,
           AppDurations.slow,
         ),
         transitionsBuilder: _transition,
       );

  static const double _travel = AppMotionOffsets.slideIn;

  static Widget _transition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final enter = CurvedAnimation(
      parent: animation,
      curve: AppCurves.emphasized,
    );
    final exit = CurvedAnimation(
      parent: secondaryAnimation,
      curve: AppCurves.emphasized,
    );

    return AnimatedBuilder(
      animation: Listenable.merge([enter, exit]),
      child: child,
      builder: (context, child) {
        final dx = _travel * (1 - enter.value) - _travel * exit.value;
        final opacity = (enter.value - exit.value).clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(offset: Offset(dx, 0), child: child),
        );
      },
    );
  }
}
