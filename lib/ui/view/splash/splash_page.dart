

import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/ui/view/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashPage extends ViewModelBuilderWidget<SplashViewModel> {

  @override
  void onViewModelReady(SplashViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) => SplashViewModel();

  @override
  Widget builder(BuildContext context, SplashViewModel viewModel, Widget? child) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          color: AppColor.background,
          child: Center(
            child: Image.asset(Images.appLogo, fit: BoxFit.fill, height: 300,),
          )
        )
      );
  }
}