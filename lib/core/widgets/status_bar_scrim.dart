import 'package:flutter/material.dart';

/// Screens draw edge to edge, so scrolled content passes under the
/// transparent status bar and the clock ends up on top of photos and banner
/// text. A strip in the screen's top colour keeps the status bar readable and
/// is invisible while the page is at rest.
class StatusBarScrim extends StatelessWidget {
  const StatusBarScrim({required this.color, required this.child, super.key});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: MediaQuery.paddingOf(context).top,
          child: ColoredBox(color: color),
        ),
      ],
    );
  }
}
