import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:j_donuts/app/motion/app_motion.dart';

/// Shakes horizontally each time [trigger] changes, so callers express the
/// effect as state (an incrementing counter) rather than holding a key to
/// call into this widget.
class ShakeTransition extends StatefulWidget {
  const ShakeTransition({
    required this.trigger,
    required this.child,
    super.key,
  });

  final int trigger;
  final Widget child;

  static const int oscillations = 3;

  @override
  State<ShakeTransition> createState() => _ShakeTransitionState();
}

class _ShakeTransitionState extends State<ShakeTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.duration = AppMotion.scaled(context, AppDurations.shake);
  }

  @override
  void didUpdateWidget(covariant ShakeTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trigger != widget.trigger) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = _controller.value;
        final decay = 1 - t;
        final wave = math.sin(t * math.pi * 2 * ShakeTransition.oscillations);
        final dx = wave * decay * AppMotionOffsets.shakeAmplitude;
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
    );
  }
}
