import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/service/alert_response.dart';
import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/base_table.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class HomePageViewModel extends VGTSBaseViewModel {
  List<PatientModel> patientsList = [];

    double ? oneCVCPercentage ;
   double ? secondCVCPercentage;
   double ? thirdCVCPercentage;
   double ? fourCVCPercentage;
   double ? fiveCVCPercentage;
   double ? sixCVCPercentage;
   List<int> listofCounts = [];




  init() async{
    setState(ViewState.Busy);
   await  fetchData();
    setState(ViewState.Idle);
  }

  fetchData() async {
    debugPrint("fetch data funtion falled");
    patientsList.clear();
    debugPrint("the patientsList length is ${patientsList.length}");

    List<PatientModel> a = await BaseTable<PatientModel>().getAll();

    List<PatientModel> b = a
        .where((element) =>
    element.userUnique_id ==
        LoginDatabase()
            .getListOfUsers
            .firstWhere((element) =>
        element.token == preferenceService.getPassCode())
            .uniqID)
        .toList();


     patientsList.addAll(b.where((element) => element.patientName !="" && element.patientName != null ).toList());
     patientsList.addAll(b.where((element) => element.patientName == "" || element.patientName == null).toList());


    oneCVCPercentage = getPercentage(a, 1);
    secondCVCPercentage = getPercentage(a, 2);
    thirdCVCPercentage = getPercentage(a, 3);
    fourCVCPercentage = getPercentage(a, 4);
    fiveCVCPercentage = getPercentage(a, 5);
    sixCVCPercentage = getPercentage(a, 6);



    notifyListeners();
  }



  double getPercentage(List<PatientModel> a, int value) {
    getCount(value,a);
    double b = (a.where((element) => element.cvscScore == value)
        .toList()
        .length /
        a.length )*
        100;
    return b.roundToDouble();
  }
  getCount(int count,a )
  {
    listofCounts.add(a.where((element) => element.cvscScore == count)
        .toList()
        .length);
    notifyListeners();
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

  deleteFuntion(model)
  async{
    AlertResponse ? alertResponse =  await dialogService.showConfirmationAlertDialog(primaryButton: "YES",secondaryButton: "NO",title: "Alert",subtitle: "Do you want to Delete this Surgery details ");

    if(alertResponse!.status)
    {
      // remove particular model in db
      await BaseTable<PatientModel>().delete(model.patientUniqID!,model);

      fetchData();
      // call init funtion
    }

    notifyListeners();

  }







}
