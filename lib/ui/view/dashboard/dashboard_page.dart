import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/ui/view/home/home_page.dart';
import 'package:curiumlife/ui/view/login/login_page.dart';
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
  DashboardViewModel viewModelBuilder(BuildContext context) =>
      DashboardViewModel();

  @override
  Widget builder(
      BuildContext context, DashboardViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime ?? DateTime.now()) >
                const Duration(seconds: 2)) {
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
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.2),
        extendBody: true,
        body: PageView(
          controller: viewModel.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [HomePage(), LogInPage()],
        ),
        bottomNavigationBar: Container(
          height: 110,
          alignment: Alignment.center,
          // padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 80,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          viewModel.updateIconIndicator(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width / 2,
                          padding: EdgeInsets.only(right: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(Images.ic_home),
                                width: 24,
                                height: 24,
                                color: viewModel.activeIndicators[0]
                                    ? AppColor.primary
                                    : AppColor.surfaceVariant,
                              ),
                              VerticalSpacing.custom(value: 8),
                              Text(
                                "SURGERY",
                                style: AppTextStyle.bodyText1.copyWith(
                                  color: viewModel.activeIndicators[0]
                                      ? AppColor.textOnSecondary
                                      : AppColor.surfaceVariant,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.updateIconIndicator(1);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 30),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage(Images.ic_search),
                                width: 24,
                                height: 24,
                                color: viewModel.activeIndicators[1]
                                    ? AppColor.primary
                                    : AppColor.surfaceVariant,
                              ),
                              VerticalSpacing.custom(value: 8),
                              Text(
                                "SEARCH",
                                style: AppTextStyle.bodyText1.copyWith(
                                  color: viewModel.activeIndicators[1]
                                      ? AppColor.textOnSecondary
                                      : AppColor.surfaceVariant,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      // GestureDetector(
                      //    onTap: (){
                      //      viewModel.updateIconIndicator(0);
                      //
                      //
                      //    },
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Image(
                      //         image: AssetImage(Images.ic_home),
                      //         width: 24,
                      //         height: 24,
                      //       color: viewModel.activeIndicators[0] ?AppColor.primary : AppColor.surfaceVariant ,
                      //       ),
                      //       VerticalSpacing.custom(value: 8),
                      //       Text(
                      //         "SURGERY",
                      //         style: AppTextStyle.bodyText1.copyWith(color: viewModel.activeIndicators[0] ?AppColor.textOnSecondary : AppColor.surfaceVariant ,),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: (){
                      //     viewModel.updateIconIndicator(1);
                      //   },
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.min,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Image(
                      //         image: AssetImage(Images.ic_search),
                      //         width: 24,
                      //         height: 24,
                      //         color: viewModel.activeIndicators[1] ?AppColor.primary : AppColor.surfaceVariant ,
                      //
                      //       ),
                      //       VerticalSpacing.custom(value: 8),
                      //       Text(
                      //         "SEARCH",
                      //         style: AppTextStyle.bodyText1.copyWith(color: viewModel.activeIndicators[1] ?AppColor.textOnSecondary : AppColor.surfaceVariant ,),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.borderColor, width: 2),
                      color: Colors.white,
                      shape: BoxShape.circle),
                  padding: EdgeInsets.all(2),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColor.secondary, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(
                        Images.ic_camera,
                      ),
                      color: Colors.white,
                      width: 25,
                      height: 25,
                    ),
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
