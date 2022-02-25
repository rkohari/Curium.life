//
// import 'package:curiumlife/core/model/service/alert_response.dart';
// import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
// import 'package:curiumlife/db/base_table.dart';
// import 'package:curiumlife/locator.dart';
// import 'package:curiumlife/ui/view/home/homepage_view_model.dart';
// import 'package:curiumlife/ui/view/vgts_base_view_model.dart';
//
// class CardWidgetViewModel extends VGTSBaseViewModel
// {
//
//   late PatientModel patientModel;
//
//   init(model)
//   {
//     patientModel = model;
//     notifyListeners();
//   }
//
//
//
//   deleteFuntion()
//   async{
//     AlertResponse ? alertResponse =  await dialogService.showConfirmationAlertDialog(primaryButton: "YES",secondaryButton: "NO",title: "Alert",subtitle: "Do you want to Delete this Surgery details ");
//
//     if(alertResponse!.status)
//     {
//       // remove particular model in db
//       await BaseTable<PatientModel>().delete(this.patientModel.patientUniqID!,this.patientModel);
//       await locator<HomePageViewModel>().fetchData();
//       // call init funtion
//     }
//
//     notifyListeners();
//
//   }
//
//
//
// }