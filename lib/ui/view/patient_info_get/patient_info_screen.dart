import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/patient_info_get/patient_info_view_model.dart';
import 'package:curiumlife/ui/widgets/button.dart';
import 'package:curiumlife/ui/widgets/dropdown.dart';
import 'package:curiumlife/ui/widgets/edit_text_field.dart';
import 'package:curiumlife/ui/widgets/tap_outside_unfocus.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PatientInfo extends ViewModelBuilderWidget<PatientInfoViewModel> {
  var data;

  @override
  void onViewModelReady(PatientInfoViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.onInIt();
  }

  @override
  PatientInfoViewModel viewModelBuilder(BuildContext context) =>
      PatientInfoViewModel();

  @override
  Widget builder(
      BuildContext context, PatientInfoViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigationService.pop();
          },
          color: AppColor.textOnPrimary,
        ),
        centerTitle: false,
        title: Text(
          "Patient Information",
          style: AppTextStyle.subtitle1.copyWith(
            color: AppColor.textOnBackground,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: TapOutsideUnFocus(
          child: Form(
            key: viewModel.patientInfoKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalSpacing.custom(value: 23),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color(0xFF979797), width: 1)),
                          child: CircleAvatar(
                            backgroundImage: FileImage(data["file"]),
                          ),
                        ),
                        VerticalSpacing.custom(value: 11),
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: 'CVSC Score :',
                              style: AppTextStyle.headline5.copyWith(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: " ${data["total"].toString()}",
                              style: AppTextStyle.headline5.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primary)),
                        ])),
                      ],
                    ),
                  ),
                  VerticalSpacing.custom(value: 24),
                  EditTextField(
                    "",
                    viewModel.patientNameController,
                    placeholder: "Patient Name",
                    onChanged: (value) {},
                    onSubmitted: (val) {
                      //  viewModel.passwordController.focusNode.requestFocus();
                    },
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 18, right: 8),
                      child: Image(
                        image: AssetImage(Images.ic_user),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  VerticalSpacing.custom(value: 16),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextField(
                          "",
                          viewModel.patientAgeController,
                          placeholder: "Age",
                          onChanged: (value) {},
                          onSubmitted: (val) {
                            //  viewModel.passwordController.focusNode.requestFocus();
                          },

                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 18, right: 8),
                            child: Image(
                              image: AssetImage(Images.ic_user),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      HorizontalSpacing.custom(value: 20),
                      Expanded(
                        child: DropdownField(
                          "",
                          viewModel.sexController,
                          placeholder: "Sex",
                          onChange: (value) {},
                        ),
                      ),
                    ],
                  ),
                  VerticalSpacing.custom(value: 16),
                  EditTextField(
                    "",
                    viewModel.patientDiagonisisController,
                    placeholder: "Diagonisis",
                    onChanged: (value) {},
                    onSubmitted: (val) {
                      //  viewModel.passwordController.focusNode.requestFocus();
                    },
                  ),
                  VerticalSpacing.custom(value: 16),
                  EditTextField(
                    "",
                    viewModel.surgeryDetailsController,
                    placeholder: "Surgery Details",
                    onChanged: (value) {},
                    onSubmitted: (val) {
                      //  viewModel.passwordController.focusNode.requestFocus();
                    },
                  ),
                  VerticalSpacing.custom(value: 16),
                  EditTextField(
                    "",
                    viewModel.additionalNotesController,
                    placeholder: "Additional Notes",
                    onChanged: (value) {
                      print(value);

                    },
                    onSubmitted: (val) {
                      //  viewModel.passwordController.focusNode.requestFocus();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                navigationService.pushNamed(Routes.dashboard);

              },
              child: Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColor.primary, width: 1)),
                alignment: Alignment.center,
                child: Text(
                  "Cancel",
                  style: AppTextStyle.bodyText2.copyWith(
                      fontSize: 16,
                      color: AppColor.textOnPrimary,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),


           GestureDetector(
              onTap:viewModel.buttonLoading? null : () {
                viewModel.controlButtonLoading(true);
                if (viewModel.patientInfoKey.currentState!.validate()) {
                  viewModel.storeIntoDB(data);
                }else
                  {
                    viewModel.controlButtonLoading(false);

                  }
              },
              child: Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.primary,
                  // border: Border.all(color:AppColor.background,width: 1)
                ),
                alignment: Alignment.center,
                child: viewModel.buttonLoading ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.black,strokeWidth: 2,)):Text(
                  "Save",
                  style: AppTextStyle.bodyText2.copyWith(
                      fontSize: 16,
                      color: AppColor.background,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PatientInfo(this.data);
}
