import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';

/// The stagger delay lives in the controller's timeline (an [Interval]) rather
/// than a timer, so nothing is left pending on dispose and tests can `pump` it.
class EntranceAnimation extends StatefulWidget {
  const EntranceAnimation({
    required this.child,
    this.index = 0,
    this.gap = AppDurations.staggerGap,
    this.duration = AppDurations.entrance,
    this.curve = AppCurves.standard,
    this.offset = const Offset(0, AppMotionOffsets.slideIn),
    this.beginScale = 1,
    super.key,
  });

  final Widget child;
  final int index;
  final Duration gap;
  final Duration duration;
  final Curve curve;
  final Offset offset;
  final double beginScale;

  @override
  State<EntranceAnimation> createState() => _EntranceAnimationState();
}

class _EntranceAnimationState extends State<EntranceAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  late Animation<double> _progress;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;

    if (AppMotion.reduceMotion(context)) {
      _progress = const AlwaysStoppedAnimation(1);
      return;
    }
    final delay = widget.gap * widget.index;
    final total = delay + widget.duration;
    final delayFraction = delay.inMicroseconds / total.inMicroseconds;
    _controller.duration = total;
    _progress = CurvedAnimation(
      parent: _controller,
      curve: Interval(delayFraction, 1, curve: widget.curve),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      child: widget.child,
      builder: (context, child) {
        final t = _progress.value;
        final translation = Offset.lerp(widget.offset, Offset.zero, t)!;
        final scale = widget.beginScale + (1 - widget.beginScale) * t;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: translation,
            child: Transform.scale(scale: scale, child: child),
          ),
        );
      },
    );
  }
}
