
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/ui/view/status/status_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FailureScreen extends ViewModelBuilderWidget<StatusViewModel> {

  @override
  void onViewModelReady(StatusViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  StatusViewModel viewModelBuilder(BuildContext context) => StatusViewModel();

  @override
  Widget builder(BuildContext context, StatusViewModel viewModel,
      Widget? child) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Error",style: AppTextStyle.headLine2.copyWith(fontSize: 24,fontWeight: FontWeight.w500,color: AppColor.error),),
              VerticalSpacing.custom(value: 24),
              Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEBEB),
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(20),
                child: const Image(

                  fit: BoxFit.cover,
                  image: AssetImage(Images.ic_error),
                ),
              ),
              VerticalSpacing.custom(value: 32),
              GestureDetector(
                onTap: () {
                  navigationService.pop();
                },
                child: Container(
                  width: 217,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.primary,
                    // border: Border.all(color:AppColor.background,width: 1)
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Back",
                    style: AppTextStyle.button.copyWith(
                        fontSize: 16,
                        color: AppColor.background,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
