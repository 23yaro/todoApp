import 'dart:ui';
import 'package:flutter/material.dart';

Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  return AnimatedBuilder(
    animation: animation,
    builder: (BuildContext context, Widget? child) {
      final double animValue = Curves.easeInOut.transform(animation.value);
      final double elevation = lerpDouble(3, 6, animValue)!;
      final double scale = lerpDouble(1, 1.02, animValue)!;
      return Transform.scale(
        scale: scale,
        child: Material(
          elevation: elevation,
          color: Colors.transparent,
          shadowColor: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          child: child,
        ),
      );
    },
    child: child,
  );
}

//Drag and Drop animation
