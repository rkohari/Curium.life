



import 'package:curiumlife/core/enum/camera_type.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/image_picker/image_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ImagePreviewScreen extends ViewModelBuilderWidget<ImagePickerViewModel> {

  var data ;
  @override
  void onViewModelReady(ImagePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  ImagePickerViewModel viewModelBuilder(BuildContext context) => ImagePickerViewModel();

  @override
  Widget builder(BuildContext context, ImagePickerViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor:Colors.black ,
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){

          navigationService.popUntil(Routes.imagePicker);
          },),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: Image(
                image: FileImage(data["file"]),
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: (){


                if(data["source"]==CameraType.GALLARY)
                {
                  viewModel.pickImageFromGallary();

                }else
                {

                  viewModel.pickImageFromCamera();

                }

              },
              child: Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color:AppColor.background,width: 1)
                ),
                alignment: Alignment.center,
                child: Text(data["source"]==CameraType.GALLARY ? "Pick Again" :"Retake",style: AppTextStyle.bodyText2.copyWith(fontSize: 16,color: AppColor.background,fontWeight: FontWeight.w400),),
              ),
            ),
            GestureDetector(
              onTap:viewModel.buttonLoading? null : () {
                viewModel.controlButtonLoading(true);

                  viewModel.gotoImageProcessScreen(data);
                viewModel.controlButtonLoading(true);
              },

              child: Container(
                width: 180,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                   color: AppColor.primary,
                   // border: Border.all(color:AppColor.background,width: 1)
                ),
                alignment: Alignment.center,
                child: viewModel.buttonLoading ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.black,strokeWidth: 2,)):Text("Use This",style: AppTextStyle.bodyText2.copyWith(fontSize: 16,color: AppColor.background,fontWeight: FontWeight.w400),),
              ),
            ),




          ],
        ),
      ),
    );
  }

  ImagePreviewScreen(this.data);
}