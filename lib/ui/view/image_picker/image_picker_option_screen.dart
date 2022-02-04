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
                  Container(
                    alignment: Alignment.center,
                    width: 269,
                    height: 110,
                    child: GestureDetector(
                      onTapDown: (dradDetails) {
                        print("on tap down called");
                        viewModel.captureContainerWidth = 259;
                        viewModel.captureContainerHeight = 100;
                        viewModel.captureIconSize=23;
                        viewModel.isCaptureTextAnimated=true;
                        viewModel.notifyListeners();
                      },
                      onTapUp: (dragDetails) {
                        viewModel.resetValues(1);
                        viewModel.pickImageFromCamera();

                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 5),
                        // curve: Curves.,
                        child: Container(
                          width: viewModel.captureContainerWidth,
                          height: viewModel.captureContainerHeight,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                  alignment: Alignment.center,
                                  width: viewModel.captureIconSize,
                                  height: viewModel.captureIconSize,
                                  duration:const Duration(seconds: 5),
                                  child: Image(
                                      image: AssetImage(Images.ic_camera),
                                    width: viewModel.captureContainerWidth,
                                    height: viewModel.captureContainerHeight,
                                  )),
                              VerticalSpacing.custom(value: 6),

                              AnimatedDefaultTextStyle(
                                child: Text('CAPTURE'),
                                style : viewModel.isCaptureTextAnimated ? AppTextStyle.subtitle1.copyWith(
                                    color: AppColor.background,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16) : AppTextStyle.subtitle1.copyWith(
                                    color: AppColor.background,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                                duration: Duration(milliseconds: 2),
                              ),

                            ],
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  VerticalSpacing.custom(value: 20),
                  Container(
                    alignment: Alignment.center,
                    width: 269,
                    height: 110,
                    child: GestureDetector(
                      onTapDown: (dradDetails) {
                        print("on tap down called");
                        viewModel.uploadContainerWidth = 259;
                        viewModel.uploadContainerHeight = 100;
                        viewModel.uploadiconSize=23;
                        viewModel.isUploadTextAnimated=true;
                        viewModel.notifyListeners();
                      },
                      onTapUp: (dragDetails) {
                        viewModel.resetValues(0);
                        viewModel.pickImageFromGallary();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 5),
                        // curve: Curves.,
                        child: Container(
                          width: viewModel.uploadContainerWidth,
                          height: viewModel.uploadContainerHeight,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                  alignment: Alignment.center,
                                  width: viewModel.uploadiconSize,
                                  height: viewModel.uploadiconSize,
                                  duration:const Duration(seconds: 5),
                                  child: Image(
                                    image: AssetImage(Images.ic_upload),
                                    width: viewModel.uploadiconSize,
                                    height: viewModel.uploadiconSize,
                                  )),
                              VerticalSpacing.custom(value: 6),

                              AnimatedDefaultTextStyle(
                                child: Text('UPLOAD'),
                                style : viewModel.isUploadTextAnimated ? AppTextStyle.subtitle1.copyWith(
                                    color: AppColor.background,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16) : AppTextStyle.subtitle1.copyWith(
                                    color: AppColor.background,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                                duration: Duration(milliseconds: 2),
                              ),

                            ],
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
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
