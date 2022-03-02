
import 'dart:io';

import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/base_table.dart';
import 'package:curiumlife/services/conver_to_prepolulated_patient_model.dart';
import 'package:curiumlife/services/file_read_service.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as pp;

class SyncService extends SyncServiceBase with FileReaderCustomFolder
{

  List<FileSystemEntity> listOfImageFiles = [];
  List<FileSystemEntity> listOfTextFiles = [];



   initiateRequestAccessPermissions()
   async{
 print("initiateRequestAccessPermissions called");
     PermissionStatus externalStatus  = await checkManageExternalStoragePermissionStatus();
     PermissionStatus storageStatus  = await checkManageStoragePermissionStatus();

     if(externalStatus.isDenied)
       await requestManageExternalStorageAccess();
     if(storageStatus.isDenied)
       await requestStorageAccess();

   }

   createCuriumFolder()
  async {
     await folderHandling();
   }


    initiateSyncProcess()
    async{
      print("initiateSyncProcess Funtion Called");
      List<List<FileSystemEntity>> temp =  await collectAllFilesInsideCuriumFolder();
      if(temp.isNotEmpty)
      {
        listOfImageFiles = List.from(temp[0]);
        listOfTextFiles = List.from( temp[1]);
      }


      // adding datas to db
      if(listOfImageFiles.isNotEmpty && listOfTextFiles.isNotEmpty)
        {
          listOfImageFiles.forEach((singleImageFile)  async {



            String imageBaseName = pp.basename(singleImageFile.path).split(".").first;

            listOfTextFiles.forEach((singleTextFile) async{

              String textFileBaseName = pp.basename(singleTextFile.path).split(".").first;

              if(imageBaseName == textFileBaseName)
              {
                print("Mathced two files");
                PatientModel model =  await ConvertToPrePopulatedPatientModel().convertToClassObject(imgeFile:singleImageFile,textFile: singleTextFile );
               await storeInsideTheDB(model);
                print("storing completed");
              }

            });

          });

        }
      print("initiateSyncProcess Funtion Completed");




    }
  clearCuriumFolder()
  {

  }

  checkFolderIsEmptyOrNot()
  async{
    // List<List<FileSystemEntity>> temp =  await collectAllFilesInsideCuriumFolder();
    // if(temp.isNotEmpty)
    // {
    //   listOfImageFiles = List.from(temp[0]);
    //   listOfTextFiles = List.from( temp[1]);
    // }
  }

 Future<bool> isRequriedPermissionsGranded()
  async{
    PermissionStatus externalStatus  = await checkManageExternalStoragePermissionStatus();
    PermissionStatus storageStatus  = await checkManageStoragePermissionStatus();
    if(externalStatus.isGranted && storageStatus.isGranted)
      {
        return true;
      }
    else
      {
        return false;
      }
  }

}




class SyncServiceBase
{

  storeInsideTheDB(PatientModel data)
  async{
    await BaseTable<PatientModel>().insert(data);

  }

}