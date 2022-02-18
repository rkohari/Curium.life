import 'package:curiumlife/db/master_database_service.dart';
import 'package:curiumlife/ui/view/camera_screen/camera_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../locator.dart';
import '../../../router.dart';
import '../vgts_base_view_model.dart';


class SplashViewModel extends VGTSBaseViewModel {

  @override
  Future onInit() async {



   await locator<MasterDatabaseService>().initialise();
 //  await locator<CameraViewModel>().initialise();




    await preferenceService.init();
    try {


      Future.delayed(const Duration(seconds: 2), () {

        if(preferenceService.getPassCode() != null || preferenceService.getPassCode() == ""){

          navigationService.popAllAndPushNamed(Routes.camera);

        }
        else
          {
            navigationService.popAllAndPushNamed(Routes.login);
          }

      });

    } catch (ex) {
      debugPrint("EXCEPTION $ex");
    }
     notifyListeners();
    return super.onInit();
  }

}