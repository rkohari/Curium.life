import 'package:curiumlife/core/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../locator.dart';
import 'dashboard_view_model.dart';

class DashboardPage extends ViewModelBuilderWidget<DashboardViewModel> {

  DateTime? currentBackPressTime;

  @override
  void onViewModelReady(DashboardViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  DashboardViewModel viewModelBuilder(BuildContext context) => DashboardViewModel();

  @override
  Widget builder(BuildContext context, DashboardViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async  {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null || now.difference(currentBackPressTime ?? DateTime.now()) > const Duration(seconds: 2)) {
          currentBackPressTime = now;
          // Fluttertoast.showToast(
          //     msg: "Click back again to exit application.",
          //     backgroundColor: AppColor.textOnBackground.withOpacity(0.8),
          //     textColor: AppColor.background
          // );
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: const Scaffold(
        backgroundColor: AppColor.surface,
        body:  Center(
          child: Text("DashBoard"),
        )
      ),
    );
  }
}
