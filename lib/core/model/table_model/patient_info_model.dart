import 'dart:typed_data';

import 'package:curiumlife/db/patient_info_constant.dart';

class PatientModel extends CVCConstant {
  String ? userUnique_id;
  String? patientUniqID;
  String ? patientName;
  int ? cvscScore;
  int  ? patientAge;
  String ? sexType;
  String ? diagoonsis;
  String  ? surgeryDetails;
  String ? additionalNotes;
  Uint8List ? picture;
  String ? date;


  // need to add these properties
  int ? c1Score;
  int ? c2Score;
  int ? c3Score;
  String ? c1Description;
  String ? c2Description;
  String ? c3Description;
  bool ? isDelete;

  PatientModel({
      this.userUnique_id,
      this.patientUniqID,
      this.patientName,
      this.cvscScore,
      this.patientAge,
      this.sexType,
      this.diagoonsis,
      this.surgeryDetails,
      this.additionalNotes,
      this.picture,
      this. c1Score, this.c2Score,this.c3Score,this.c1Description,this.c2Description,this.c3Description,
      this.date,
      this.isDelete

  });


  Future<PatientModel> fromMap(Map<String, dynamic>  data) async {
    userUnique_id = data[col_userUnique_id];
    patientUniqID = data[col_PatientUniqID];
    patientName = data[col_PatientName];
    cvscScore = data[col_CvscScore];
    patientAge = data[col_PatientAge];
    sexType = data[col_SexType];
    diagoonsis = data[col_Diagoonsis];
    surgeryDetails = data[col_SurgeryDetails];
    additionalNotes = data[col_AdditionalNotes];
    picture = data[col_Picture];

    //

    c1Score = data[col_c1Score];
    c2Score = data[col_c2Score];
    c3Score = data[col_c3Score];
    c1Description = data[col_c1Description];
    c2Description = data[col_c2Description];
    c3Description = data[col_c3Description];
    date = data[col_date];
    isDelete = data[col_isDelete];


    return this;
  }

  Map<String, dynamic> toDatabaseMap() {
    Map<String, dynamic> data = {};
    data[col_userUnique_id] = this.userUnique_id;
    data[col_PatientUniqID] = this.patientUniqID;
    data[col_PatientName] = this.patientName;
    data[col_CvscScore] = this.cvscScore;
    data[col_SexType] = this.sexType;
    data[col_PatientAge] = this.patientAge;
    data[col_Diagoonsis] = this.diagoonsis;
    data[col_SurgeryDetails] = this.surgeryDetails;
    data[col_AdditionalNotes] = this.additionalNotes;
    data[col_Picture] = this.picture;

    //
    data[col_c1Score] = this.c1Score;
    data[col_c2Score] = this.c2Score;
    data[col_c3Score] = this.c3Score;
    data[col_c1Description] = this.c1Description;
    data[col_c2Description] = this.c2Description;
    data[col_c3Description] = this.c3Description;
    data[col_date] = this.date;
    data[col_isDelete] = data[isDelete];

    print(data);






    return data;
  }


}
