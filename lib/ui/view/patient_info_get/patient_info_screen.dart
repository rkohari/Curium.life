import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/patient_info_get/patient_info_view_model.dart';
import 'package:curiumlife/ui/widgets/dropdown.dart';
import 'package:curiumlife/ui/widgets/edit_text_field.dart';
import 'package:curiumlife/ui/widgets/tap_outside_unfocus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/enum/view_state.dart';

class PatientInfo extends ViewModelBuilderWidget<PatientInfoViewModel> {
  var data;

  @override
  void onViewModelReady(PatientInfoViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.onInIt(data);
  }

  @override
  PatientInfoViewModel viewModelBuilder(BuildContext context) =>
      PatientInfoViewModel();

  @override
  Widget builder(
      BuildContext context, PatientInfoViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async{
        navigationService.popAllAndPushNamed(Routes.dashboard);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          // leading: GestureDetector(
          //   onTap: () {
          //     navigationService.popAllAndPushNamed(Routes.dashboard);            },
          //   child: Container(
          //     width: 28,
          //     height: 28,
          //     alignment: Alignment.center,
          //     child: Image(
          //       width: 28,
          //       height: 28,
          //       fit: BoxFit.cover,
          //       image: AssetImage(Images.ic_back),
          //     ),
          //   ),
          // ),

          leading: IconButton(icon: Icon(CupertinoIcons.chevron_back), onPressed: () async{

            navigationService.popAllAndPushNamed(Routes.dashboard);
          },
            color: Colors.black,iconSize: 25,
          ),
          centerTitle: false,
          titleSpacing: 0,
          title: Text(
            "Patient Information",
            style: AppTextStyle.subText.copyWith(
              color: AppColor.textOnBackground,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: viewModel.patientInfoKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TapOutsideUnFocus(
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
                          viewModel.state == ViewState.Busy?Container() :  Container(
                            width: 90,
                            height: 90,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFF979797), width: 1)),
                            child: CircleAvatar(
                              backgroundImage: MemoryImage(viewModel.model!.picture!),
                            ),
                          ),
                          VerticalSpacing.custom(value: 11),
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: 'CVS Score :',
                                style: AppTextStyle.headLine2.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:viewModel.state == ViewState.Busy ? "" :" ${viewModel.model!.cvscScore!.toString()}",
                                style: AppTextStyle.headLine2.copyWith(
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
                      autoFocus: true,
                      onChanged: (value) {},
                      onSubmitted: (val) {
                        //  viewModel.passwordController.focusNode.requestFocus();
                      },
                      prefixIcon: const Padding(
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
                            viewModel.genderTypeController,
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
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                    VerticalSpacing.custom(value: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          height: 70,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [

              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    navigationService.popAllAndPushNamed(Routes.dashboard);                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.primary, width: 1)),
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: AppTextStyle.subText.copyWith(
                          fontSize: 16,
                          color: AppColor.textOnPrimary,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              HorizontalSpacing.custom(value: 16),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: viewModel.buttonLoading
                      ? null
                      : () {
                          viewModel.controlButtonLoading(true);
                          if (viewModel.patientInfoKey.currentState!.validate()) {
                            if (viewModel.patientNameController.text
                                    .trim()
                                    .isEmpty ||
                                viewModel.patientNameController.text.length < 3) {
                              viewModel.showDialogBox(
                                  "Enter Atleast 3 letters in name field");
                              return;
                            } else if (viewModel.patientNameController.text[0] ==
                                " ") {
                              viewModel
                                  .showDialogBox("Remove Space in name field");
                              return;
                            } else if (viewModel.patientDiagonisisController.text
                                .trim()
                                .isEmpty) {
                              viewModel.showDialogBox("Enter Diagonisis Content");

                              return;
                            } else if (viewModel.surgeryDetailsController.text
                                    .trim()
                                    .isEmpty ||
                                viewModel.surgeryDetailsController.text.length <
                                    3  ) {
                              viewModel.showDialogBox(
                                  "Enter Atleast 3 letters in surgery field");

                              return;
                            }

                            else if(viewModel.surgeryDetailsController.text
                                .trim().length <3)
                              {
                                viewModel.showDialogBox(
                                    "Remove Space in in surgery field");

                                return;
                              }

                            viewModel.storeIntoDB(data);
                          } else {
                            viewModel.controlButtonLoading(false);
                          }
                        },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.primary,
                      // border: Border.all(color:AppColor.background,width: 1)
                    ),
                    alignment: Alignment.center,
                    child: viewModel.buttonLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ))
                        : Text(
                            "Save",
                            style: AppTextStyle.subText.copyWith(
                                fontSize: 16,
                                color: AppColor.background,
                                fontWeight: FontWeight.w400),
                          ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  PatientInfo(this.data);
}
