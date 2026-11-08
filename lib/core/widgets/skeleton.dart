import 'package:flutter/material.dart';
import 'package:j_donuts/app/motion/app_motion.dart';
import 'package:j_donuts/app/theme/app_colors.dart';
import 'package:j_donuts/app/theme/app_spacing.dart';

/// Under Reduce Motion the shimmer stops and the block stays a flat tint: a
/// sweeping highlight is exactly the kind of motion users opt out of.
class Skeleton extends StatefulWidget {
  const Skeleton({
    this.width,
    this.height,
    this.radius = AppRadii.md,
    this.shape = BoxShape.rectangle,
    super.key,
  });

  const Skeleton.circle({required double size, super.key})
    : width = size,
      height = size,
      radius = 0,
      shape = BoxShape.circle;

  final double? width;
  final double? height;
  final double radius;
  final BoxShape shape;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.skeletonShimmer,
  );

  static const double _bandHalfWidth = 0.6;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduceMotion(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
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
      builder: (context, _) {
        final center = -1 + 3 * _controller.value;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            shape: widget.shape,
            borderRadius: widget.shape == BoxShape.circle
                ? null
                : BorderRadius.circular(widget.radius),
            gradient: LinearGradient(
              begin: Alignment(center - _bandHalfWidth, 0),
              end: Alignment(center + _bandHalfWidth, 0),
              colors: const [
                AppColors.skeletonBase,
                AppColors.skeletonHighlight,
                AppColors.skeletonBase,
              ],
            ),
          ),
        );
      },
    );
  }
}
