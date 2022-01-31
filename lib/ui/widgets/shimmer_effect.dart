import 'package:curiumlife/core/res/colors.dart';
import 'package:flutter/material.dart';



class ShimmerEffect extends StatefulWidget {
  final double height;
  final double width;
  final EdgeInsets margin;
  final BorderRadius borderRadius;

  ShimmerEffect({required Key key, this.height = 70, this.width = double.infinity, this.borderRadius = BorderRadius.zero ,this.margin = EdgeInsets.zero}) : super(key: key);

  createState() => ShimmerEffectState();
}

class ShimmerEffectState extends State<ShimmerEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: widget.borderRadius
      ),
      child: Container(
        width:  widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(gradientPosition.value, 0),
                end: Alignment(-1, 0),
                colors: [Colors.white12, Color(0xfff4f4f4), Colors.white12]
            )
        ),
      ),
    );
  }
}