import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/ui/view/view_patient_details/patient_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PatientDetails extends ViewModelBuilderWidget<PatientDetailsViewModel> {
  PatientModel patientModel;

  @override
  void onViewModelReady(PatientDetailsViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  PatientDetailsViewModel viewModelBuilder(BuildContext context) =>
      PatientDetailsViewModel();

  @override
  Widget builder(
      BuildContext context, PatientDetailsViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //     navigationService.pop();
          //   },
          //   color: AppColor.textOnPrimary,
          // ),
          leading: GestureDetector(
            onTap: (){
              navigationService.pop();
            },
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Image(
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                image: AssetImage(Images.ic_back),
              ),
            ),
          ),
          centerTitle: false,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patientModel.patientName ?? "",
                    style: AppTextStyle.headLine2.copyWith(
                        fontSize: 26,

                        fontWeight: FontWeight.bold,
                        color: AppColor.textOnBackground),
                  ),
                  VerticalSpacing.custom(value: 10),
                  Text(
                    "${patientModel.patientAge.toString()} / ${patientModel.sexType}",
                    style: AppTextStyle.headLine2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B779A)),

                  ),
                  VerticalSpacing.custom(value: 10),
                  Text(
                    "${patientModel.diagoonsis}",
                    style: AppTextStyle.headLine2.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B779A)),
                  ),
                  VerticalSpacing.custom(value: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 230,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Image(
                        width: double.infinity,
                        height: 230,
                        image: MemoryImage(patientModel!.picture!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  VerticalSpacing.custom(value: 14),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'CVSC SCORE :',
                        style: AppTextStyle.headLine2.copyWith(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " ${patientModel.cvscScore.toString()}",
                        style: AppTextStyle.headLine2.copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary)),
                  ])),
                  VerticalSpacing.custom(value: 12),
                  Text("Surgery Details",
                      style: AppTextStyle.headLine2.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 10),
                  Text(patientModel.surgeryDetails ?? "",
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 15),
                  Text("Additional Notes",
                      style: AppTextStyle.headLine2.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 10),
                  Text(patientModel.additionalNotes ?? "",
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 15),
                  Container(
                    height: .6,
                    width: double.infinity,
                    color: Color(0xFFDDDDDD),
                  ),
                  VerticalSpacing.custom(value: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("C1",
                          style: AppTextStyle.headLine2.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B779A))),
                      Text("${patientModel.c1Score.toString()} / 2",
                          style: AppTextStyle.headLine2.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B779A))),
                    ],
                  ),
                  VerticalSpacing.custom(value: 8),
                  Text(patientModel.c1Description.toString(),
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 16),
                  Container(
                    height: .6,
                    width: double.infinity,
                    color: Color(0xFFDDDDDD),
                  ),
                  VerticalSpacing.custom(value: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("C2",
                          style: AppTextStyle.headLine2.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B779A))),
                      Text("${patientModel.c2Score.toString()} / 2",
                          style: AppTextStyle.headLine2.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B779A))),
                    ],
                  ),
                  VerticalSpacing.custom(value: 8),
                  Text(patientModel.c2Description.toString(),
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 16),
                  Container(
                    height: .6,
                    width: double.infinity,
                    color: Color(0xFFDDDDDD),
                  ),
                  VerticalSpacing.custom(value: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("C3",
                          style: AppTextStyle.headline1.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B779A))),
                      Text("${patientModel.c3Score.toString()} / 2",
                          style: AppTextStyle.headline1.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B779A))),
                    ],
                  ),
                  VerticalSpacing.custom(value: 8),
                  Text(patientModel.c3Description!,
                      style: AppTextStyle.overline.copyWith(
                          fontSize: 12,
                          color: Color(0xFF6B779A))),
                  VerticalSpacing.custom(value: 16),
                ],
              ),
            )),
      ),
    );
  }

  PatientDetails(this.patientModel);
}
