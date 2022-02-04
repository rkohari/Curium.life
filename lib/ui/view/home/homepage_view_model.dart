import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/base_table.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';

class HomePageViewModel extends VGTSBaseViewModel {
  List<PatientModel> patientsList = [];

  init() {
    fetchData();
  }

  fetchData() async {
    patientsList.clear();
    List<PatientModel> a = await BaseTable<PatientModel>().getAll();

    print(
        "the token is ${preferenceService.getPassCode()} and the use uniq id is ${LoginDatabase().getListOfUsers.firstWhere((element) => element.token == preferenceService.getPassCode()).uniqID}");

    a.forEach((element) {
      print(element.userUnique_id);
    });

    patientsList = a
        .where((element) => element.userUnique_id == LoginDatabase().getListOfUsers.firstWhere((element) => element.token == preferenceService.getPassCode()).uniqID)
        .toList();

    print("the pathents list is ${patientsList.length}");
    notifyListeners();
  }

  logout() {
    print("logout called");
    preferenceService.clearData();
    navigationService.popAllAndPushNamed(Routes.login);
    notifyListeners();
  }
}
