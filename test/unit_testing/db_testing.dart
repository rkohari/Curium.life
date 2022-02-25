import 'package:curiumlife/db/master_database_service.dart';
import 'package:curiumlife/locator.dart';
import 'package:flutter/cupertino.dart';

class DBTesting
{

  DBTesting(){
    debugPrint("---------- Locator Setup Initialized ------------");
    setupLocator();
    debugPrint("----------- Locator Setup Completed --------------");
     locator<MasterDatabaseService>().initialise();




  }
  // arrange

  // exececution

  // testing


}