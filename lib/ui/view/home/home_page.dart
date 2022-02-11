import 'dart:ui';

import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:curiumlife/ui/view/widget/patient_info_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:stacked/stacked.dart';
import 'homepage_view_model.dart';

class HomePage extends ViewModelBuilderWidget<HomePageViewModel> {
  @override
  void onViewModelReady(HomePageViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  HomePageViewModel viewModelBuilder(BuildContext context) =>
      HomePageViewModel();
  int touchedIndex = -1;

  @override
  Widget builder(
      BuildContext context, HomePageViewModel viewModel, Widget? child) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: viewModel.state == ViewState.Busy
            ? Container(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColor.primary,
                  ),
                ),
              )
            : getBody(context, viewModel));
  }

  getBody(context, viewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .3,
                  alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.background),
                          fit: BoxFit.cover)),
                  padding: EdgeInsets.only(left: 20, right: 20, top: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Surgery Details",
                        style: AppTextStyle.headline1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Lato-Regular"),
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.logout();
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFCCF5E1)),
                          alignment: Alignment.center,
                          child: const Image(
                            image: AssetImage(Images.ic_logout),
                            width: 14,
                            height: 16.73,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, top: 100),
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * .35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3fa6aeaa),
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: viewModel.patientsList.length == 0
                        ? Text(
                            "No Anaytics Data Added",
                            style: AppTextStyle.button
                                .copyWith(color: Colors.black.withOpacity(.5)),
                          )
                        : Container(
                            alignment: Alignment.topCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 2,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (FlTouchEvent event,
                                                      pieTouchResponse) {}),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 40,
                                          sections: [
                                            pieChartSectionDataWidget(
                                              viewModel.oneCVCPercentage,
                                              Color(0xFF4485FD),
                                            ),
                                            pieChartSectionDataWidget(
                                              viewModel.secondCVCPercentage,
                                              Color(0xFFA584FF),
                                            ),
                                            pieChartSectionDataWidget(
                                              viewModel.thirdCVCPercentage,
                                              Color(0xFFFF7854),
                                            ),
                                            pieChartSectionDataWidget(
                                              viewModel.fourCVCPercentage,
                                              Color(0xFFFEA725),
                                            ),
                                            pieChartSectionDataWidget(
                                              viewModel.fiveCVCPercentage,
                                              Color(0xFF00CC6A),
                                            ),
                                            pieChartSectionDataWidget(
                                              viewModel.sixCVCPercentage,
                                              Color(0xFF00C9E4),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                                Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceAround ,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 7.5,
                                              width: 7.5,
                                              margin: EdgeInsets.only(top: 2.2),
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF4485FD),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text("value-01",
                                                style: AppTextStyle.overline
                                                    .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(.50),
                                                    fontSize: 11))
                                          ],
                                        ),
                                        VerticalSpacing.custom(value: 3),
                                        Text("${viewModel.listofCounts[0]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),
                                      ],
                                    ),

                                    Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 6,
                                              width: 6,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFA584FF),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text("value-02",
                                                style: AppTextStyle.overline
                                                    .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(.50),
                                                    fontSize: 11))
                                          ],
                                        ),
                                        VerticalSpacing.custom(value: 3),

                                        Text("${viewModel.listofCounts[1]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                                      ],
                                    ),

                                    Column(
                                     children: [
                                       Row(
                                         mainAxisSize: MainAxisSize.min,
                                         mainAxisAlignment:
                                         MainAxisAlignment.center,
                                         crossAxisAlignment:
                                         CrossAxisAlignment.center,
                                         children: [
                                           Container(
                                             height: 6,
                                             width: 6,
                                             decoration: const BoxDecoration(
                                               color: Color(0xFFFF7854),
                                               shape: BoxShape.circle,
                                             ),
                                           ),
                                           const SizedBox(
                                             width: 3,
                                           ),
                                           Text("value-03",
                                               style: AppTextStyle.overline
                                                   .copyWith(
                                                   color: Colors.black
                                                       .withOpacity(.50),
                                                   fontSize: 11))
                                         ],
                                       ),
                                       VerticalSpacing.custom(value: 3),
                                       Text("${viewModel.listofCounts[2]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                                     ],
                                   ),

                                 Column(
                                   children: [
                                     Row(
                                       mainAxisSize: MainAxisSize.min,
                                       mainAxisAlignment:
                                       MainAxisAlignment.center,
                                       crossAxisAlignment:
                                       CrossAxisAlignment.center,
                                       children: [
                                         Container(
                                           height: 6,
                                           width: 6,
                                           decoration: const BoxDecoration(
                                             color: Color(0xFFFEA725),
                                             shape: BoxShape.circle,
                                           ),
                                         ),
                                         const SizedBox(
                                           width: 3,
                                         ),
                                         Text("value-04",
                                             style: AppTextStyle.overline
                                                 .copyWith(
                                                 color: Colors.black
                                                     .withOpacity(.50),
                                                 fontSize: 11))
                                       ],
                                     ),
                                     VerticalSpacing.custom(value: 3),

                                     Text("${viewModel.listofCounts[3]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                                   ],
                                 )   ,

                                    Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 6,
                                              width: 6,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF00CC6A),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text("value-05",
                                                style: AppTextStyle.overline
                                                    .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(.50),
                                                    fontSize: 11))
                                          ],
                                        ),
                                        VerticalSpacing.custom(value: 3),
                                        Text("${viewModel.listofCounts[4]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                                      ],
                                    ),

                                    Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 6,
                                              width: 6,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF00C9E4),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text("value-06",
                                                style: AppTextStyle.overline
                                                    .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(.50),
                                                    fontSize: 10))
                                          ],
                                        ),
                                        VerticalSpacing.custom(value: 3),

                                        Text("${viewModel.listofCounts[5]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                                      ],
                                    )


                                  ],
                                ),
                                HorizontalSpacing.custom(value: 20),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          VerticalSpacing.custom(value: 12),
          viewModel.patientsList.isEmpty
              ? Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .55,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(left: 20,right:20 ,top: 10),
                    padding: EdgeInsets.only(bottom: 30),
                    decoration:const  BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border(
                        top: BorderSide(color: Color(0xFFEEEEEE), width: 2),
                        left: BorderSide(color: Color(0xFFEEEEEE), width: 2),
                        right: BorderSide(color: Color(0xFFEEEEEE), width: 2),
                        bottom: BorderSide(color: Color(0xFFEEEEEE), width: 2),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '"Start by\nclicking on the\ncamera icon"',
                          style: AppTextStyle.headline1.copyWith(
                              color: Color(0xFFC6C6C6),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        VerticalSpacing.custom(value: 12),
                        Container(
                          height: 41,
                          alignment: Alignment.center,
                          child: Image(
                            height: 41,
                            fit: BoxFit.cover,
                            image: AssetImage(Images.ic_down_arrow),
                          ),
                        ),
                        VerticalSpacing.custom(value: 26),
                      ],
                    ),
                  ),
                )
              : Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimationLimiter(
                      child: GridView.count(
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: .85,
                        primary: false,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        crossAxisCount: 2,
                        children: List.generate(
                          viewModel.patientsList.length,
                          (int index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: 2,
                              position: index,
                              duration: Duration(milliseconds: 500),
                              child: ScaleAnimation(
                                scale: 0.5,
                                child: FadeInAnimation(
                                  child: PatientInfoWidget(
                                      viewModel.patientsList[index]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
          VerticalSpacing.custom(value: 100),
        ],
      ),
    );
  }

  PieChartSectionData pieChartSectionDataWidget(double value, Color color) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '${value?.toInt() ?? 0}%',
      radius: 40,
      titleStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    );
  }
}
