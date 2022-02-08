import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/service/alert_response.dart';
import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/base_table.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';

class HomePageViewModel extends VGTSBaseViewModel {
  List<PatientModel> patientsList = [];

    double ? oneCVCPercentage ;
   double ? secondCVCPercentage;
   double ? thirdCVCPercentage;
   double ? fourCVCPercentage;
   double ? fiveCVCPercentage;
   double ? sixCVCPercentage;

  init() async{
    setState(ViewState.Busy);
   await  fetchData();
    setState(ViewState.Idle);
  }

  fetchData() async {
    patientsList.clear();
    List<PatientModel> a = await BaseTable<PatientModel>().getAll();

    patientsList = a
        .where((element) =>
    element.userUnique_id ==
        LoginDatabase()
            .getListOfUsers
            .firstWhere((element) =>
        element.token == preferenceService.getPassCode())
            .uniqID)
        .toList();

    oneCVCPercentage = getPercentage(a, 1);
    secondCVCPercentage = getPercentage(a, 2);
    thirdCVCPercentage = getPercentage(a, 3);
    fourCVCPercentage = getPercentage(a, 4);
    fiveCVCPercentage = getPercentage(a, 5);
    sixCVCPercentage = getPercentage(a, 6);



    notifyListeners();
  }



  double getPercentage(List<PatientModel> a, int value) {

    double b = (a.where((element) => element.cvscScore == value)
        .toList()
        .length /
        a.length )*
        100;
    return b.roundToDouble();
  }



  logout() async{
    AlertResponse ? alertResponse =  await dialogService.showConfirmationAlertDialog(primaryButton: "YES",secondaryButton: "NO",title: "Logout",subtitle: "Do you want to leave this account ");

    if(alertResponse!.status)
    {
      print("logout called");
      preferenceService.clearData();
      navigationService.popAllAndPushNamed(Routes.login);
      notifyListeners();
    }


  }


}
