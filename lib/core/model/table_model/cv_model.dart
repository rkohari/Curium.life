import 'package:curiumlife/db/cvc_constant.dart';

class CVModel extends CVCConstant {
  int ? userUniqID;

  int? patientUniqID;
  String ?c1;

  String ?c2;

  String ? c3;

  CVModel({this.userUniqID, this.patientUniqID, this.c1, this.c2, this.c3});

  Future<CVModel> fromMap(Map<String, dynamic>  data) async {
    userUniqID = data[col_userUniqID];
    patientUniqID = data[col_patientUniqID];
    c1 = data[col_c1];
    c2 = data[col_c2];
    c3 = data[col_c3];
    return this;
  }

  Map<String, dynamic> toDatabaseMap() {
    Map<String, dynamic> data = {};
    data[col_userUniqID] = this.userUniqID;
    data[col_userUniqID] = this.patientUniqID;
    data[col_c1] = this.c1;
    data[col_c2] = this.c2;
    data[col_c3] = this.c3;
    return data;
  }
}
