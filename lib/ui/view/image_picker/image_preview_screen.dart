



import 'package:curiumlife/core/enum/camera_type.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/image_picker/image_picker_view_model.dart';
import 'package:flutter/cupertino.dart';
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
    return WillPopScope(
      onWillPop: () async{
        navigationService.pushReplacementNamed(Routes.dashboard);

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor:Colors.black ,
            // leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            //
            //   navigationService.pushReplacementNamed(Routes.dashboard);
            // },),
            leading: IconButton(onPressed: () {
              navigationService.pushReplacementNamed(Routes.dashboard);

            }, icon:Icon(CupertinoIcons.chevron_back),

              iconSize: 27,
            ),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){

                    navigationService.pushReplacementNamed(Routes.camera);

                  },
                  child: Container(

                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color:AppColor.background,width: 1)
                    ),
                    alignment: Alignment.center,
                    child: Text(data["source"]==CameraType.GALLARY ? "Pick Again" :"Retake",style: AppTextStyle.button.copyWith(fontSize: 16,color: AppColor.background,fontWeight: FontWeight.w400),),
                  ),
                ),
              ),
              HorizontalSpacing.custom(value: 16),
              Expanded(
                child: GestureDetector(
                  onTap:viewModel.buttonLoading? null : () {
                    viewModel.controlButtonLoading(true);

                      viewModel.gotoImageProcessScreen(data);
                    viewModel.controlButtonLoading(true);
                  },

                  child: Container(

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
                        child: CircularProgressIndicator(                            color: Colors.white,
                          strokeWidth: 2,)):Text("Use This",style: AppTextStyle.button.copyWith(fontSize: 16,color: AppColor.background,fontWeight: FontWeight.w400),),
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }

  ImagePreviewScreen(this.data);
}