
import 'dart:io';
import 'dart:typed_data';

import 'package:curiumlife/core/enum/camera_type.dart';
import 'package:curiumlife/db/base_table.dart';
import 'package:curiumlife/db/curium_data.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/services/tensorflow_service.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../core/model/table_model/patient_info_model.dart';
import '../../../db/logins.dart';
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






  gotoImageProcessScreen (var data)
  {
    navigationService.pushNamed(Routes.imageProcess,arguments: data);

  }


  // image process screen funtions added here

  processImageWithTensorFlow(mapData)
 async {
    CVCPOINTS = 0.0;



     String predictiedImage = await getScore(mapData["file"]);



    Future.delayed(Duration(seconds: 1),(){
      CuriumLife curiumLife =  CuriumLife();

     final imageObject =curiumLife.getImageInfo(predictiedImage);

      int totalscore = imageObject.c1Score + imageObject.c2Score +imageObject.c3Score;
      DateTime timeStamp= DateTime.now();
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
        "date" :DateFormat('yyyy-mm-dd h:m a').format(timeStamp).toString()

      };

      navigationService.pushNamed(Routes.imageInfo,arguments: data);

      });

  }



  //image information screen funtions
  gotoPatientInfoScreen(data)
   async{

    Map params = await storeInsideTheDB(data);

     navigationService.pushNamed(Routes.patientInfo,arguments:params).then((value)  {
       controlButtonLoading(false);
     });

   }

  Future<Map> storeInsideTheDB(data)
   async{

     Uint8List ? image = await testCompressFile(data["file"]);
     String uniqId = Uuid().v1();

     await BaseTable<PatientModel>().insert(PatientModel(

   userUnique_id: LoginDatabase().getListOfUsers.firstWhere((element) => element.token == preferenceService.getPassCode()).uniqID,
   patientUniqID: uniqId,

   cvscScore: data["total"],
   c1Score: data["c1Score"],
   c2Score: data["c2Score"],
   c3Score: data["c3Score"],
   picture: image,
   c1Description: data["c1_des"],
   c2Description: data["c2_des"],
   c3Description: data["c3_des"],
   date:  (DateFormat('yyyy-MM-dd h:m a').format(DateTime.now())).toString()
   ));

   Map params ={"patientUniqId" : uniqId};

   return  params;
   }


  Future<Uint8List?> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 40,
      rotate: 0,
    );

    return result;
  }

  bool buttonLoading =false;

  controlButtonLoading(bool value)
  {
    buttonLoading = value;
    notifyListeners();
  }

}