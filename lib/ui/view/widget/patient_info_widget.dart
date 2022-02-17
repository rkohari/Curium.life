import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../locator.dart';

class PatientInfoWidget extends StatelessWidget {
  late PatientModel patientModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationService.pushNamed(Routes.patientDetails,
            arguments: patientModel);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x0f000000),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 105,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  image: DecorationImage(
                    image: MemoryImage(patientModel!.picture!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing.custom(value: 10),
                  Text(
                    patientModel!.patientName ?? "",
                    maxLines: 1,
                    style: AppTextStyle.button.copyWith(
                        color: Color(0xFF222B45),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  VerticalSpacing.custom(value: 6),
                  Text(
                    "${patientModel!.patientAge ?? ""} / ${patientModel!.sexType ?? ""}",
                    maxLines: 1,
                    style: AppTextStyle.subText.copyWith(
                        color: Color(0xFF6B779A),
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  VerticalSpacing.custom(value: 6),
                  Text(
                    patientModel.diagoonsis ?? "",
                    maxLines: 1,
                    style: AppTextStyle.subText.copyWith(
                        color: Color(0xFF6B779A),
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                  VerticalSpacing.custom(value: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  PatientInfoWidget(this.patientModel);
}
