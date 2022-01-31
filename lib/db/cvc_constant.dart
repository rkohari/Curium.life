
import 'package:curiumlife/db/base_table.dart';

class CVCConstant extends BaseConstant
{



  CVCConstant(){
    tableName = "CVCSCORE";
    primaryKey= col_patientUniqID;

  }

  String col_userUniqID = "userUniqID";
   String col_patientUniqID ="patientUniq";
  String col_c1 = "c1";
  String col_c2 = "c2";
  String col_c3 = "c3";


  String get createQuery {
    return "CREATE TABLE $tableName ("
        "$col_userUniqID INTEGER NOT NULL PRIMARY KEY,"
        "$col_patientUniqID TEXT,"
        "$col_c1 TEXT,"
        "$col_c2 TEXT,"
        "$col_c3 TEXT"
        ")";
  }


}