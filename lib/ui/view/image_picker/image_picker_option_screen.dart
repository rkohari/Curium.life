import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/ui/view/image_picker/image_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ImagePickerChoices extends ViewModelBuilderWidget<ImagePickerViewModel> {
  @override
  void onViewModelReady(ImagePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  ImagePickerViewModel viewModelBuilder(BuildContext context) =>
      ImagePickerViewModel();

  @override
  Widget builder(
      BuildContext context, ImagePickerViewModel viewModel, Widget? child) {
    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 53),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.appLogo,
                    fit: BoxFit.contain,
                    height: 200,
                    width: 200,
                  ),
                  VerticalSpacing.custom(value: 35),
                  GestureDetector(
                   onTap: viewModel.buttonLoading ? null :(){
                   if(viewModel.buttonLoading)
                     {
                       return ;
                     }
                   viewModel.controlButtonLoading(true);
                   viewModel.pickImageFromCamera();

                   },

                    child: Container(
                      
                      width: 269,
                      height:110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 24,
                              child: Image(
                                image: AssetImage(Images.ic_camera),
                                width: 30,
                                height: 24,
                              )),
                          VerticalSpacing.custom(value: 6),

                         Text("CAPTURE",style: AppTextStyle.subText.copyWith(
                             color: AppColor.background,
                             fontWeight: FontWeight.w600,
                             fontSize: 18),)

                        ],
                      ),
                    ),
                  ),
                  VerticalSpacing.custom(value: 20),
                  GestureDetector(
                    onTap: viewModel.buttonLoading ? null :(){
                      if(viewModel.buttonLoading)
                      {
                        return ;
                      }
                      viewModel.controlButtonLoading(true);
                      viewModel.pickImageFromGallary();
                    },
                    child: Container(

                      width: 269,
                      height:110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Container(
                              alignment: Alignment.center,
                              width: 39,
                              height: 24,
                              child: Image(

                                image: AssetImage(Images.ic_upload),
                                width: 39,
                                height: 24,
                              ),
                         ),
                          VerticalSpacing.custom(value: 6),

                          Text("UPLOAD",style: AppTextStyle.subText.copyWith(
                              color: AppColor.background,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),)

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
