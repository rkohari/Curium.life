import 'package:camera/camera.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/core/res/styles.dart';
import 'package:curiumlife/ui/view/camera_screen/camera_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CameraScreen extends ViewModelBuilderWidget<CameraViewModel> {
  @override
  void onViewModelReady(CameraViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.initialise();
  }

  @override
  CameraViewModel viewModelBuilder(BuildContext context) => CameraViewModel();

  @override
  Widget builder(
      BuildContext context, CameraViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.closeCameraScreen();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * .1,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.textOnPrimary,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only( top: 25, left: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(
                            "Identify the Image",
                            style: AppTextStyle.subText.copyWith(
                                color: Colors.white,
                                fontSize: 16,

                                fontWeight: FontWeight.normal),
                          )),
                      IconButton(onPressed: () {

                        viewModel.closeCameraScreen();
                      }, icon: Icon(CupertinoIcons.clear),
                      color: Colors.white,
                        iconSize: 24,
                      ),
                      // HorizontalSpacing.custom(value: 16),
                    ],
                  )),
              Container(

                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .7,

                child: FutureBuilder(
                  future: viewModel.getCamInitResponse,
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return  CameraPreview(
                        viewModel.cameraController,
                        child: Align(
                          alignment: Alignment.center,

                        ),
                      );
                      // show the camera widget;
                    }
                    return Container();
                  },
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width,
                color: AppColor.textOnPrimary,
                alignment: Alignment.center,
                child:  GestureDetector(
                  onTap: () async{
                    await viewModel.moveToImagePreviewScreen();
                  },
                  child: Container(

                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.borderColor,
                            width: 2),
                        color: Colors.white,
                        shape: BoxShape.circle),
                    padding: EdgeInsets.all(1),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColor.secondary,
                          shape: BoxShape.circle),
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
                ),
              ),
            ],
 
          ),
        ),
      ),
    );
  }
}
