import 'package:curiumlife/core/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {

  final String message;
   final double height;
  Loading({required this.message, required this.height});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.7),
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColor.primary),
          ),
        ),
      ),
    );
  }
}