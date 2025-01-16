import 'dart:io';
import 'package:flutter/material.dart';

class CustomPopScope extends StatelessWidget {

  final VoidCallback? onPopScope;
  final Widget? child;

  const CustomPopScope({super.key,this.child,this.onPopScope});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 700) {
          onPopScope!.call();
        }
      },
      child: child,
    ) : PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          onPopScope!.call();
        },
        child: child ?? const SizedBox()
    );
  }
}