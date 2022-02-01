import 'package:curiumlife/db/master_database_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../locator.dart';
import '../../../router.dart';
import '../vgts_base_view_model.dart';


class SplashViewModel extends VGTSBaseViewModel {

  @override
  Future onInit() async {
   await locator<MasterDatabaseService>().initialise();





    await preferenceService.init();
    try {
      Future.delayed(const Duration(seconds: 1), () {
        navigationService.popAllAndPushNamed(Routes.dashboard);
        // if (preferenceService.getBearerToken().isNotEmpty) {
        //   navigationService.popAllAndPushNamed(Routes.dashboard);
        // } else {
        //   navigationService.popAllAndPushNamed(Routes.login);
        // }
      });

    } catch (ex) {
      debugPrint("EXCEPTION $ex");
    }

    return super.onInit();
  }

}