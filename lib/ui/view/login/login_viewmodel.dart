import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/responce_wrapper.dart';
import 'package:curiumlife/core/model/user_model.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:curiumlife/locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';

import '../../../router.dart';
import '../vgts_base_view_model.dart';

class LogInViewModel extends VGTSBaseViewModel {
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

  login() async {
    // try {
    setState(ViewState.Busy);
    Future.delayed(Duration(seconds: 3), () {
      ResponseData data = _loginDatabase.validateLoginDetails(
          loginIdController.text.toLowerCase().trim(),
          passwordController.text.trim());
      setState(ViewState.Idle);

      if (data.status == ResponceStatus.COMPLETED) {
        preferenceService.setPassCode(data.data!.token);
        updateUserModel(data.data as UserModel);
        navigationService.popAllAndPushNamed(
          Routes.dashboard,
        );
      } else {
        print("login failure");
      }
    });

    notifyListeners();
  }
}
