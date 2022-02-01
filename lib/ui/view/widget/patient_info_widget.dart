import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PatientInfoWidget extends StatelessWidget {
  const PatientInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 105,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight:Radius.circular(8) ),
               image: DecorationImage(
                 image: AssetImage(Images.background),
                 fit: BoxFit.cover
               )
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing.custom(value: 10),
                Text("Vinoth Kumar.K",maxLines: 1,style: AppTextStyle.overline.copyWith(color: Color(0xFF222B45),fontWeight: FontWeight.bold,fontSize: 16),),
                VerticalSpacing.custom(value: 6),
                Text("102/Male",maxLines: 1,style: AppTextStyle.button.copyWith(color: Color(0xFF6B779A),fontWeight: FontWeight.normal,fontSize: 12),),
                VerticalSpacing.custom(value: 6),
                Text("Hearth Surgerory",maxLines: 1,style: AppTextStyle.button.copyWith(color: Color(0xFF6B779A),fontWeight: FontWeight.w500,fontSize: 12),),
                VerticalSpacing.custom(value: 20),

              ],
            ),
          )


        ],
      ),
    );
  }
}
