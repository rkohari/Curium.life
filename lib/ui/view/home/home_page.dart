import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/ui/view/widget/patient_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stacked/stacked.dart';

import 'homepage_view_model.dart';

class HomePage extends ViewModelBuilderWidget<HomePageViewModel> {
  @override
  void onViewModelReady(HomePageViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  HomePageViewModel viewModelBuilder(BuildContext context) =>
      HomePageViewModel();

  @override
  Widget builder(
      BuildContext context, HomePageViewModel viewModel, Widget? child) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .5,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  alignment: Alignment.center,

                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.background),
                          fit: BoxFit.cover)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hellow David",
                        style: AppTextStyle.headline5.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic),
                      ),
                      GestureDetector(
                        onTap: (){
                          viewModel.logout();
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFCCF5E1)),
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage(Images.ic_logout),
                            width: 14,
                            height: 16.73,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // child: AppBar(centerTitle: false,title: Text("Hello David"),backgroundColor: Colors.transparent,actions: [
                  //   InkWell(
                  //       onTap:(){},
                  //       child: Icon(Icons.height,color: Colors.blue))
                  // ],),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: MediaQuery.of(context).size.height * .3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.primary,
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
          VerticalSpacing.custom(value: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AnimationLimiter(
              child: GridView.count(
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .9,
                primary: false,
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: 2,
                children: List.generate(
                  50,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: 2,
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: const ScaleAnimation(
                        scale: 0.5,
                        child: FadeInAnimation(
                          child: PatientInfoWidget(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          VerticalSpacing.custom(value: 100),
        ],
      ),
    ));
  }
}
