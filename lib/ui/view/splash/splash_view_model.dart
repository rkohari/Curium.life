import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:curiumlife/db/curium_data.dart';
import 'package:curiumlife/services/conver_to_prepolulated_patient_model.dart';
import 'package:curiumlife/services/sync_service.dart';
import 'package:mock_data/mock_data.dart' as mock;

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

class SplashViewModel extends VGTSBaseViewModel{


  SyncService syncService = SyncService();
  @override
  Future onInit() async {



   await locator<MasterDatabaseService>().initialise();

   if(await syncService.isFolderExists())
     {
       await syncService.initiateSyncProcess();
     }
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



   storeInsideTheDB(PatientModel data)
  async{



    await BaseTable<PatientModel>().insert(data);


  }



}