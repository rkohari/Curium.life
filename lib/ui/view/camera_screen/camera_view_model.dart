import 'dart:io';

import 'package:camera/camera.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';
import 'package:camera/camera.dart' as CustomCamera;
import 'package:flutter/material.dart';

class CameraViewModel extends VGTSBaseViewModel {
   late List<CameraDescription> cameras;

  late CameraController _controller;

  CameraController get cameraController => _controller;

  late Future<void> _initializeControllerFuture;

  get getCamInitResponse => _initializeControllerFuture;

  initialise() async {
    print("************ the camera funtion inited  ***********");

    cameras = await CustomCamera.availableCameras();
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();

    notifyListeners();
  }

  moveToImagePreviewScreen() async {

    print("moveToImagePreviewScreen funtion called");

    XFile xFile = await _controller.takePicture();

    File file = File(xFile!.path);
    Map<String, dynamic> params = {
      "source": "Camera",
      "file": file,
    };

    navigationService.pushNamed(Routes.imagePreview, arguments: params);
  }

  closeCameraScreen()
  {
    navigationService.pushReplacementNamed(Routes.dashboard);

  }

  int i=0;
  switchCamera()
  {

    if(i==0)
      {
        i==1;
      }else
        {
          i==0;
        }

    _controller = CameraController(
      cameras[i],
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
 notifyListeners();
  }



}
