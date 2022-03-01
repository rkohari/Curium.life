import 'dart:io';
import 'dart:typed_data';

import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/master_database_service.dart';
import 'package:curiumlife/services/file_read_service.dart';
import 'package:curiumlife/ui/view/camera_screen/camera_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../../../db/base_table.dart';
import '../../../locator.dart';
import '../../../router.dart';
import '../vgts_base_view_model.dart';

import 'package:path/path.dart' as pp;

class SplashViewModel extends VGTSBaseViewModel with FileReaderCustomFolder{


  List<FileSystemEntity> listOfImageFiles = [];
  List<FileSystemEntity> listOfTextFiles = [];
  String path = "";
  @override
  Future onInit() async {



   await locator<MasterDatabaseService>().initialise();


  path = await checkIsFolderExists();
  List<List<FileSystemEntity>> temp =  await browingCuriumFolder();
  if(temp.isNotEmpty)
    {
      listOfImageFiles = List.from(temp[0]);
      listOfTextFiles = List.from( temp[1]);
    }

  // reading text file data


   listOfImageFiles.forEach((singleImageFile)  async {

     // final _myFile = File(element.path);
     // String content =await  _myFile.readAsString();

     // get image name and entension name

     String imageBaseName = pp.basename(singleImageFile.path).split(".").first;

     listOfTextFiles.forEach((singleTextFile) async{

       String textFileBaseName = pp.basename(singleTextFile.path).split(".").first;

       if(imageBaseName == textFileBaseName)
         {
           print("Mathced two files");
           PatientModel model =  await convertToClassObject(imgeFile:singleImageFile,textFile: singleTextFile );
           storeInsideTheDB(model);
           print("storing completed");
         }

     });




   });






    await preferenceService.init();



      if(preferenceService.getPassCode() != null || preferenceService.getPassCode() == ""){

        navigationService.popAllAndPushNamed(Routes.camera);

      }
      else
      {
        navigationService.popAllAndPushNamed(Routes.login);
      }


     notifyListeners();
    return super.onInit();
  }

  convertToClassObject({required FileSystemEntity imgeFile,required FileSystemEntity textFile})
  async{
    File file = File(imgeFile.path);
    Uint8List ? image = await testCompressFile(file);
    String uniqId = Uuid().v1();
    String tempDate =(DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now())).toString();



   return  PatientModel(

      userUnique_id: "1",
      patientUniqID: uniqId,

      cvscScore: 1,
      c1Score: 1,
      c2Score: 1,
      c3Score: 1,
      picture: image,
      c1Description: "NA",
      c2Description: "NA",
      c3Description: "NA",
      date:  tempDate,
        patientName : "",
       patientAge : 12,
    sexType : "Male",
    diagoonsis : "NA",
    surgeryDetails : "NA",
   additionalNotes : "NA",
      isDelete: true,
    );






  }

   storeInsideTheDB(PatientModel data)
  async{



    await BaseTable<PatientModel>().insert(data);


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
}