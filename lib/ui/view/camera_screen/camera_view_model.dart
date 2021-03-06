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
    try {
      print("moveToImagePreviewScreen funtion called");

     final XFile xFile = await _controller.takePicture();

      File file = File(xFile!.path);
      Map<String, dynamic> params = {
        "source": "Camera",
        "file": file,
      };

      navigationService.pushReplacementNamed(Routes.imagePreview, arguments: params);
    }
    catch (e)
    {
      print("${e.toString()}");
    }
  }

  closeCameraScreen()
  {
    navigationService.pushReplacementNamed(Routes.dashboard);

  }

  int i=0;
  switchCamera()
  {
    print("called");

    if(i==0)
      {
        i==1;
      }else
        {
          i==0;
        }

    print(i);
    _controller = CameraController(
      cameras[i],
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
 notifyListeners();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("dispose method called");
    _controller.dispose();
  }

}
