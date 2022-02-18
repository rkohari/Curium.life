import 'package:camera/camera.dart';
import 'package:curiumlife/core/res/colors.dart';
import 'package:curiumlife/core/res/images.dart';
import 'package:curiumlife/core/res/spacing.dart';
import 'package:curiumlife/ui/view/camera_screen/camera_view_model.dart';
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
        return false;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: viewModel.getCamInitResponse,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(

                  body: Stack(
                fit: StackFit.expand,
                children: [
                  CameraPreview(
                    viewModel.cameraController,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          GestureDetector(
                            onTap: () {
                              viewModel.closeCameraScreen();
                            },
                            child: Container(

                              height: MediaQuery.of(context).size.height * .1,
                              width: MediaQuery.of(context).size.width,
                              color:AppColor.textOnPrimary,
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 33.58,
                                    height: 33.58,
                                    alignment: Alignment.center,
                                    child: const Image(
                                      fit: BoxFit.cover,
                                      width: 33.58,
                                      height: 33.58,
                                      image: AssetImage(Images.ic_cross),
                                    ),
                                  ),
                                  HorizontalSpacing.custom(value: 16),
                                ],
                              )
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .7,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .2,
                            width: MediaQuery.of(context).size.width,
                            color:AppColor.textOnPrimary,
                            alignment: Alignment.center,
                            child:     GestureDetector(
                              onTap:(){

                                viewModel.moveToImagePreviewScreen();

                              },
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.borderColor, width: 2),
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                padding: EdgeInsets.all(1),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: AppColor.secondary, shape: BoxShape.circle),
                                  alignment: Alignment.center,
                                  child:  Image(
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
                ],
              ));
              // show the camera widget;
            }
            return Text("wait a sec");
          },
        ),
      ),
    );
  }
}
