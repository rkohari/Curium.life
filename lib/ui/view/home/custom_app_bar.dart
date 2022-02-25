import 'dart:math';

import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/ui/view/home/homepage_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/res/spacing.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate
{
  HomePageViewModel viewModel;


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    return   Container(


      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .28,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.background),
                    fit: BoxFit.cover),

            ),
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
                    child:  Image(
                      image: AssetImage(Images.ic_logout),
                      width: 14,
                      height: 16.73,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Opacity(
            opacity: 1- max(0.0 , shrinkOffset- 1)/400,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 110),
                padding: EdgeInsets.all(13),
                height: MediaQuery.of(context).size.height * .25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity( 1!- max(0.0 , shrinkOffset- 1)/400),
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
                  // alignment: Alignment.topCenter,
                  child: FittedBox(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width :200,
                          height: 200,
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
                                      value :  viewModel.oneCVCPercentage!,
                                      color :  Color(0xFF4485FD),
                                      count :   viewModel.listofCounts[0]
                                  ),
                                  pieChartSectionDataWidget(
                                      value :  viewModel.secondCVCPercentage!,
                                      color : Color(0xFFA584FF),
                                      count :   viewModel.listofCounts[1]
                                  ),
                                  pieChartSectionDataWidget(
                                      value :   viewModel.thirdCVCPercentage!,
                                      color : Color(0xFFFF7854),
                                      count :   viewModel.listofCounts[2]
                                  ),
                                  pieChartSectionDataWidget(
                                      value :   viewModel.fourCVCPercentage!,
                                      color : Color(0xFFFEA725),
                                      count :   viewModel.listofCounts[3]
                                  ),
                                  pieChartSectionDataWidget(
                                      value :   viewModel.fiveCVCPercentage!,
                                      color :   Color(0xFF00CC6A),
                                      count :   viewModel.listofCounts[4]
                                  ),
                                  pieChartSectionDataWidget(
                                      value :  viewModel.sixCVCPercentage!,
                                      color :   Color(0xFF00C9E4),
                                      count : viewModel.listofCounts[5]
                                  ),
                                ]),
                          ),
                        ),
                        HorizontalSpacing.custom(value: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      margin: EdgeInsets.only(top: 2.2),
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF4485FD),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text("CVS-01",
                                      style: AppTextStyle.subText.copyWith(
                                          color: Color(0xFF6B779A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),)
                                  ],
                                ),

                              ],
                            ),
                            VerticalSpacing.custom(value: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFA584FF),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text("CVS-02",
                                      style: AppTextStyle.subText.copyWith(
                                          color: Color(0xFF6B779A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),)
                                  ],
                                ),


                                //       Text("${viewModel.listofCounts[1]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                              ],
                            ),
                            VerticalSpacing.custom(value: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFF7854),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text("CVS-03",
                                      style: AppTextStyle.subText.copyWith(
                                          color: Color(0xFF6B779A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),),
                                  ],
                                ),

                                //    Text("${viewModel.listofCounts[2]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                              ],
                            ),
                            VerticalSpacing.custom(value: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFEA725),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text("CVS-04",
                                      style: AppTextStyle.subText.copyWith(
                                          color: Color(0xFF6B779A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),),
                                  ],
                                ),


                                //     Text("${viewModel.listofCounts[3]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                              ],
                            )   ,
                            VerticalSpacing.custom(value: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF00CC6A),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text("CVS-05",
                                      style: AppTextStyle.subText.copyWith(
                                          color: Color(0xFF6B779A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),),
                                  ],
                                ),

                                //   Text("${viewModel.listofCounts[4]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 10),),

                              ],
                            ),
                            VerticalSpacing.custom(value: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 8,
                                      width: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF00C9E4),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text("CVS-06",
                                      style: AppTextStyle.subText.copyWith(
                                          color: Color(0xFF6B779A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),),
                                  ],
                                ),


                                //    Text("${viewModel.listofCounts[5]}",style: AppTextStyle.subText2.copyWith(color: Colors.black,fontSize: 15),),

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
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent =>  310;

  @override
  // TODO: implement minExtent
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  CustomAppBar(this.viewModel);
}






PieChartSectionData pieChartSectionDataWidget({double ? value, Color ? color, int? count = 0}) {
  return PieChartSectionData(
    color: color,
    value: value,
    title: '${value?.toInt() ?? 0}% \n { $count }',
    radius: 44,
    titleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: const Color(0xffffffff)),
  );
}