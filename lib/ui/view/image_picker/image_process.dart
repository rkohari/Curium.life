import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/image_picker/image_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

class ImageProcessScreen extends ViewModelBuilderWidget<ImagePickerViewModel> {

  var data ;

  ImageProcessScreen(this.data);

  @override
  void onViewModelReady(ImagePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.processImageWithTensorFlow(data);
  }



  @override
  ImagePickerViewModel viewModelBuilder(BuildContext context) => ImagePickerViewModel();

  @override
  Widget builder(BuildContext context, ImagePickerViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: Scaffold(

          body: Stack(
            children: [
              Container(

                 width: double.infinity,
                height: double.infinity,
                child: Image(image: FileImage(data["file"]),),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color:  Color(0xc4000000),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(

                  alignment: Alignment.center,
                  child: const SpinKitRing(
                    size: 50,
                    color: AppColor.primary,
                  ),


                ),
              ),
          //    Color(0xc4000000),
            ],
          )
      ),
    );
  }

}