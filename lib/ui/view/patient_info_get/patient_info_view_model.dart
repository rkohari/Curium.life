import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

  controlButtonLoading(bool value)
  {
    buttonLoading = value;
    notifyListeners();
  }

  late GenderType sexType ;



  onInIt() {
    genderTypeController.list = sexTypeList;
    notifyListeners();
  }

  SetDropDownValue(GenderType type) {
    this.sexType = type;
    notifyListeners();
  }

  storeIntoDB(data) async {

    try {
     // Uint8List image = await convertFileToUint8List(data["file"]);
      Uint8List ? image = await testCompressFile(data["file"]);

      await BaseTable<PatientModel>().insert(PatientModel(

          userUnique_id: LoginDatabase().getListOfUsers.firstWhere((element) => element.token == preferenceService.getPassCode()).uniqID,
          patientUniqID: Uuid().v1(),
          patientName: patientNameController.text,
          patientAge: int.parse(patientAgeController.text.trim()),
          cvscScore: data["total"],
          sexType: genderTypeController.value!.sexType,
          diagoonsis: patientDiagonisisController.text,
          surgeryDetails: surgeryDetailsController.text,
          additionalNotes: additionalNotesController.textEditingController.text,
          picture: image,
          c1Score: data["c1Score"],
          c2Score: data["c2Score"],
          c3Score: data["c3Score"],
          c1Description: data["c1_des"],
          c2Description: data["c2_des"],
          c3Description: data["c3_des"]
      ));
      //
      controlButtonLoading(false);

      navigationService.pushNamed(Routes.success);
    }
    catch (e) {
      // failure screen
      print("************");
      print(e.toString());
  //    navigationService.pushNamed(Routes.failure);

    }
  }

  Future<Uint8List> convertFileToUint8List(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    return uint8list;
  }



  Future<Uint8List?> testCompressFile(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      minWidth: 2300,
      minHeight: 1500,
      quality: 40,
      rotate: 90,
    );

    return result;
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
