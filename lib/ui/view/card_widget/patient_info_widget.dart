import 'dart:ui';

import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/card_widget/card_widget_view_model.dart';
import 'package:curiumlife/ui/view/home/homepage_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';

import '../../../locator.dart';

class PatientInfoWidget extends StatelessWidget {
  late PatientModel patientModel;
  Function(PatientModel)? onTap;


 // VoidCallback callbackHandle;
  PatientInfoWidget(this.patientModel,
  { this.onTap}
     // ,this.callbackHandle
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        navigationService.pushNamed(Routes.patientDetails,
            arguments: patientModel);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0x0f000000),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 105,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  image: DecorationImage(
                    image: MemoryImage(patientModel.picture!),
                    fit: BoxFit.cover,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing.custom(value: 10),
                  Text(
                    patientModel!.patientName ?? "${patientModel.date}",
                    maxLines: 1,
                    style: patientModel.patientName == "" ||  patientModel.patientName == null ? AppTextStyle.button.copyWith(
                        color: Color(0xFF222B45),
                        fontWeight: FontWeight.bold,
                        fontSize: 13) : AppTextStyle.button.copyWith(
                        color: Color(0xFF222B45),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  VerticalSpacing.custom(value: 2),
                  Text(
                    patientModel!.patientName == null ||  patientModel!.patientName == "" ? "UnAssociated Data": "${patientModel!.patientAge ?? ""} / ${patientModel!.sexType ?? ""}",
                    maxLines: 1,
                    style: AppTextStyle.subText.copyWith(
                        color: Color(0xFF6B779A),
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                  VerticalSpacing.custom(value: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          patientModel.diagoonsis ?? "---",
                          maxLines: 1,
                          style: AppTextStyle.subText.copyWith(
                              color: Color(0xFF6B779A),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                       HorizontalSpacing.custom(value: 5),
                      onTap== null ? Container():   InkWell(
                           onTap:(){
                             this.onTap!(patientModel);
                           },
                           child: Icon(CupertinoIcons.delete,size: 18,color: Colors.deepOrangeAccent[200],))
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(),
                  //
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}





//
// class PatientInfoWidget extends ViewModelBuilderWidget<CardWidgetViewModel> {
//   late PatientModel model;
//   PatientInfoWidget(this.model);
//
//   @override
//   void onViewModelReady(CardWidgetViewModel viewModel) {
//     super.onViewModelReady(viewModel);
//
//     viewModel.init(model);
//
//   }
//
//   @override
//   CardWidgetViewModel viewModelBuilder(BuildContext context) => CardWidgetViewModel();
//
//   @override
//   Widget builder(BuildContext context, CardWidgetViewModel viewModel, Widget? child) {
//
//     return GestureDetector(
//       onTap: () {
//         navigationService.pushNamed(Routes.patientDetails,
//             arguments: viewModel.patientModel);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0x0f000000),
//               blurRadius: 1,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Container(
//               height: 105,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8)),
//                   image: DecorationImage(
//                     image: MemoryImage(viewModel.patientModel.picture!),
//                     fit: BoxFit.cover,
//                   )),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 10,right: 10),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   VerticalSpacing.custom(value: 10),
//                   Text(
//                     viewModel.patientModel!.patientName ?? "${viewModel.patientModel.date}",
//                     maxLines: 1,
//                     style: viewModel.patientModel.patientName == "" ||  viewModel.patientModel.patientName == null ? AppTextStyle.button.copyWith(
//                         color: Color(0xFF222B45),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 13) : AppTextStyle.button.copyWith(
//                         color: Color(0xFF222B45),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16),
//                   ),
//                   VerticalSpacing.custom(value: 2),
//                   Text(
//                     viewModel.patientModel!.patientName == null ||  viewModel.patientModel!.patientName == "" ? "UnAssociated Data": "${viewModel.patientModel!.patientAge ?? ""} / ${viewModel.patientModel!.sexType ?? ""}",
//                     maxLines: 1,
//                     style: AppTextStyle.subText.copyWith(
//                         color: Color(0xFF6B779A),
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12),
//                   ),
//                   VerticalSpacing.custom(value: 6),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: Text(
//                           viewModel.patientModel.diagoonsis ?? "---",
//                           maxLines: 1,
//                           style: AppTextStyle.subText.copyWith(
//                               color: Color(0xFF6B779A),
//                               fontWeight: FontWeight.w500,
//                               fontSize: 12),
//                         ),
//                       ),
//                       HorizontalSpacing.custom(value: 5),
//                       InkWell(
//                           onTap: (){
//                             print("tap called");
//
//                             viewModel.deleteFuntion();
//                             viewModel.notifyListeners();
//                           },
//                           child: Icon(CupertinoIcons.delete,size: 18,color: Colors.deepOrangeAccent[200],))
//                     ],
//                   ),
//                   // Padding(
//                   //   padding: const EdgeInsets.only(right: 10),
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //     children: [
//                   //       Container(),
//                   //
//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//
//   }
// }