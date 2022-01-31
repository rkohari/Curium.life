

import 'dart:convert';

import 'package:curiumlife/core/res/colors.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {

  final String image;
  final double height;
  final double width;
  final BorderRadius? radius;
  final EdgeInsets? margin;

  ImageView(this.image, { this.height = 74, this.width = 74, this.margin ,this.radius });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius == null ? BorderRadius.circular(12.0) : radius ,
      child:Container(
        decoration: BoxDecoration(
          color: AppColor.background,
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(8),
        ),
        child: Image.memory(base64Decode(image), fit: BoxFit.cover,),
        //Image.file(controller.imageFile,width:104,height:104,fit: BoxFit.cover,),
        height: height,
        width: width,
        margin: margin
      ),
    );
  }

}