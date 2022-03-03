import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/responce_wrapper.dart';
import 'package:curiumlife/core/model/user_model.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/services/sync_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart' as cam;
import 'package:vgts_plugin/form/utils/form_field_controller.dart';

import '../../../router.dart';
import '../vgts_base_view_model.dart';

class LogInViewModel extends VGTSBaseViewModel  {
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();

  ScrollController scrollController = ScrollController();

  TextFormFieldController loginIdController = TextFormFieldController(
      const ValueKey("txtLoginId"),
      requiredText: "Please enter Login Id",
      required: true);
  TextFormFieldController passwordController = TextFormFieldController(
      const ValueKey("txtPassword"),
      requiredText: "Please enter Password",
      required: true);
  LoginDatabase _loginDatabase = LoginDatabase();
  SyncService syncService = SyncService();

  init()
  async{
    await checkCameraPermission();
    await syncService.initiateRequestAccessPermissions();
  }
  checkCameraPermission() async {
    debugPrint("checkCameraPermission called");
    var status = await cam.Permission.camera.status;
    debugPrint("$status");
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      await cam.Permission.camera.request();
    }
  }

  login() async {
    // try {

    // store that funtion
    // and login



    setState(ViewState.Busy);

    // check the permission
    // and store the data
    if(await syncService.isRequriedPermissionsGranded())
      {
        await syncService.createCuriumFolder();
        await syncService.initiateSyncProcess();
      }


    await Future.delayed(Duration(seconds: 1), () {
      ResponseData data = _loginDatabase.validateLoginDetails(
          loginIdController.text.toLowerCase().trim(),
          passwordController.text.trim());
      setState(ViewState.Idle);

      if (data.status == ResponceStatus.COMPLETED) {
        preferenceService.setPassCode(data.data!.token);
        updateUserModel(data.data as UserModel);
        navigationService.pushNamed(Routes.camera);
      } else {
        dialogService.showDialog(description: "Enter Correct Login Details");
      }
    });

    notifyListeners();
  }

  showDialogBox(String text) {
    dialogService.showDialog(title: "Alert Message", description: "$text");
  }
}
