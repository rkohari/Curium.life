
import 'dart:io';

import 'package:curiumlife/core/enum/camera_type.dart';
import 'package:curiumlife/db/curium_data.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/services/tensorflow_service.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerViewModel extends VGTSBaseViewModel with TensorFlowService
{



   ImagePicker picker = ImagePicker();

// captured button controles
  double captureContainerWidth = 269;
  double captureContainerHeight = 100;
  bool isCaptureTextAnimated = false;
  double captureIconSize =26;

  double uploadContainerWidth = 269;
  double uploadContainerHeight = 100;
  bool isUploadTextAnimated = false;
  double uploadiconSize=26;


  // ML score
  late double CVCPOINTS;

  resetValues (int value)
  {

    if(value == 1)
      {
        captureContainerWidth = containerWidth;
        captureContainerHeight = containerHeight;
        isCaptureTextAnimated = isAnimated;
        captureIconSize = iconSize;
      }else
        {
          uploadContainerWidth = containerWidth;
          uploadContainerHeight = containerHeight;
          isUploadTextAnimated = isAnimated;
          uploadiconSize =iconSize;
        }



    notifyListeners();


  }

  pickImageFromCamera () async{
    controlButtonLoading(false);

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    File file =File(photo!.path);
    Map<String,dynamic>  params={
      "source" : CameraType.CAMERA,
      "file" : file,
    };
    navigationService.pushNamed(Routes.imagePreview,arguments: params);
  }

  pickImageFromGallary () async {
    controlButtonLoading(false);

    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    File file =File(photo!.path);
    Map<String,dynamic>  params={
      "source" : CameraType.GALLARY,
      "file" : file,
    };
    navigationService.pushNamed(Routes.imagePreview,arguments: params);

  }


  gotoImageProcessScreen (var data)
  {
    navigationService.pushNamed(Routes.imageProcess,arguments: data);

  }


  processImageWithTensorFlow(mapData)
 async {
    CVCPOINTS = 0.0;
      print("processImageWithTensorFlow");
     String predictiedImage = await getScore(mapData["file"]);



    Future.delayed(Duration(seconds: 3),(){
      CuriumLife curiumLife =  CuriumLife();
      print("image object called 1");
     final imageObject =curiumLife.getImageInfo(predictiedImage);
      print("image object called");
      int totalscore = imageObject.c1Score + imageObject.c2Score +imageObject.c3Score;
      print("c1 score ${totalscore}  ${CuriumLife().c1[imageObject.c1Score]}");
      Map data = {
        "file" : mapData["file"],
        "imageName":predictiedImage,
        "c1_des" :  CuriumLife().c1[imageObject.c1Score],
        "c2_des" :  CuriumLife().c2[imageObject.c2Score],
        "c3_des" :  CuriumLife().c3[imageObject.c3Score],
        "total"  : totalscore,
        "c1Score" : imageObject.c1Score,
        "c2Score" : imageObject.c2Score,
        "c3Score" : imageObject.c3Score,


      };
      navigationService.pushNamed(Routes.imageInfo,arguments: data);

      });

  }


   gotoPatientInfoScreen(data)
   {

     navigationService.pushNamed(Routes.patientInfo,arguments: data).then((value)  {
       controlButtonLoading(false);

     });

   }



  bool buttonLoading =false;

  controlButtonLoading(bool value)
  {
    buttonLoading = value;
    notifyListeners();
  }

}