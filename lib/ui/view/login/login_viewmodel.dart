import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/table_model/cv_model.dart';
import 'package:curiumlife/db/base_table.dart';
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
        navigationService.popAllAndPushNamed(
          Routes.dashboard,
        );
      } else {
        print("login failure");
      }
    });

    notifyListeners();
  }

  get() async {
    print("get called");

    List<CVModel> a = await BaseTable<CVModel>().getAll();

    a.forEach((element) {
      print(element.userUniqID);
    });
    // if(logInFormKey.currentState?.validate() != true) {
    //   return;
    // }
    // setState(ViewState.Busy);
    // setState(ViewState.Idle);
    // notifyListeners();
  }
}

// int a = await BaseTable<CVModel>().insert(CVModel(userUniqID:123456,patientUniqID:007,c1:"hi",c2:"hello",c3: "world"));
// print("the a is ${a}");
// if(logInFormKey.currentState?.validate() != true) {
//   return;
// }
// setState(ViewState.Busy);
// setState(ViewState.Idle);
// notifyListeners();
