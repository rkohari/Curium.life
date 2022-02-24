import 'package:flutter/material.dart';

/// Simple wrapper that will clear focus when a tap is detected outside its boundaries
class TapOutsideUnFocus extends StatelessWidget {
  final Widget child;
  final Function? onTap;

  TapOutsideUnFocus({required this.child,this.onTap});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          onTap: () {

            if(onTap != null){
              onTap!();
            }
            // Clear focus of our fields when tapped in this empty space
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: this.child
      );
  }
}