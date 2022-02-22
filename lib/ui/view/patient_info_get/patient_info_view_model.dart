import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/base_model.dart';
import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/base_table.dart';
import 'package:curiumlife/db/logins.dart';
// import 'package:curiumlife/helper/input_formatter.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:vgts_plugin/form/utils/input_formatter.dart';

import '../../../locator.dart';
class PatientInfoViewModel extends VGTSBaseViewModel {
  final GlobalKey<FormState> patientInfoKey = GlobalKey<FormState>();

  DropdownFieldController<GenderType> genderTypeController =
      DropdownFieldController<GenderType>(ValueKey("dIndustry"),
          keyId: "id", valueId: "sexType", required: true);

  FormFieldController patientNameController = FormFieldController(
      const ValueKey("PatientName"),
      required: true,
      maxLength:50,
    inputFormatter: InputFormatter.nameFormatter,
  );

  FormFieldController patientAgeController = FormFieldController(
      const ValueKey("Age"),
      required: true,
      inputFormatter:[
        FilteringTextInputFormatter.digitsOnly,
      ],
     textInputType: TextInputType.number,maxLength: 2

  );

  FormFieldController patientDiagonisisController = FormFieldController(
      const ValueKey("diagonisis"),
      required: true,
      maxLength:150,
inputFormatter: InputFormatter.nameFormatter,

  );

  FormFieldController surgeryDetailsController = FormFieldController(
      ValueKey("surgeryDetails"),
      required: true,
    maxLength:250,
    inputFormatter: InputFormatter.nameFormatter,

      minLines: 5,

  );

  FormFieldController additionalNotesController = FormFieldController(
      ValueKey("additionalNotes"),
      required: true,
    maxLength:250,
    inputFormatter: InputFormatter.nameFormatter,

    minLines: 5,

  );


  bool buttonLoading =false;



  late GenderType sexType ;

 PatientModel ? model;
  onInIt(params) async{

    setState(ViewState.Busy);
    genderTypeController.list = sexTypeList;


     print("the passed uniq id is ${params["patientUniqId"]}");
    List<PatientModel> a = await BaseTable<PatientModel>().getAll();
    List<PatientModel>   patientsList = a
        .where((element) =>
    element.userUnique_id ==
        LoginDatabase()
            .getListOfUsers
            .firstWhere((element) =>
        element.token == preferenceService.getPassCode())
            .uniqID)
        .toList();

     model = patientsList.firstWhere((element) => element.patientUniqID == params["patientUniqId"]);

     print("model uniq id is ${model!.patientUniqID}");
    setState(ViewState.Idle);
    notifyListeners();
  }

  SetDropDownValue(GenderType type) {
    this.sexType = type;
    notifyListeners();
  }

  storeIntoDB(data) async {

    try {

        print("the uniq id is storeIntoDB${model!.patientUniqID}");

        model!.patientName = patientNameController.text;
        model!.patientAge = int.parse(patientAgeController.text.trim());
        model!.sexType = genderTypeController.value!.sexType;
        model!.diagoonsis = patientDiagonisisController.text;
        model!.surgeryDetails = surgeryDetailsController.text;
        model!.additionalNotes = additionalNotesController.textEditingController.text;

        print(model!.toDatabaseMap());
        // print("the base table is oging to upate");
         await BaseTable<PatientModel>().update(model!.patientUniqID.toString(),model! );
        // print("the base table is oging to upate1 ");
        controlButtonLoading(false);

        navigationService.popAllAndPushNamed(Routes.dashboard);
    }
    catch (e) {
      controlButtonLoading(false);
      print(e.toString());


    }
  }





  controlButtonLoading(bool value)
  {
    buttonLoading = value;
    notifyListeners();
  }

 showDialogBox(String text)
 {
   controlButtonLoading(false);

   dialogService.showDialog(title: "Alert Message",description: "$text");

 }





}

class GenderType extends BaseModel {
  int? id;
  String? sexType;

  GenderType({this.id, this.sexType});

  GenderType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sexType = json['sexType'];
  }

  GenderType fromJson(Map<String, dynamic> json) => GenderType.fromJson(json);

  @override
  bool operator ==(Object other) {
    return other is GenderType && other.id == id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sexType'] = this.sexType;
    return data;
  }
}

List<GenderType> sexTypeList = [
  GenderType(id: 1, sexType: "Male"),
  GenderType(id: 2, sexType: "Female"),
  GenderType(id: 3, sexType: "Other"),
];
