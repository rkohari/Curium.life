
import 'package:curiumlife/db/base_table.dart';

class CVCConstant extends BaseConstant
{



  CVCConstant(){
    tableName = "CVCSCORE";
    primaryKey= col_PatientUniqID;

  }

  // String col_userUniqID = "userUniqID";
  //  String col_patientUniqID ="patientUniq";
  // String col_c1 = "c1";
  // String col_c2 = "c2";
  // String col_c3 = "c3";




  String  col_userUnique_id = "unique_id";
  String col_PatientUniqID = "patientUniqID";
  String  col_PatientName ="patientName";
  String  col_CvscScore ="cvscScore";
  String   col_PatientAge= "patientAge";
  String  col_SexType= "sexType";
  String  col_Diagoonsis ="diagoonsis";
  String  col_SurgeryDetails ="surgeryDetails";
  String  col_AdditionalNotes= "additionalNotes";
  String  col_Picture = "picture";

//
  String  col_c1Score = "c1Score";
  String  col_c2Score = "c2Score";
  String  col_c3Score = "c3Score";
  String  col_c1Description = "c1Description";
  String  col_c2Description = "c2Description";
  String  col_c3Description = "c3Description";
  String  col_date = "date";
  String col_isDelete = "isDelete";



  String get createQuery {
    return "CREATE TABLE $tableName ("
        "$col_PatientUniqID STRING NOT NULL PRIMARY KEY,"
        "$col_userUnique_id TEXT,"
        "$col_PatientName TEXT,"
        "$col_CvscScore INTEGER,"
        "$col_PatientAge INTEGER,"
        "$col_SexType TEXT,"
        "$col_Diagoonsis TEXT,"
        "$col_SurgeryDetails TEXT,"
        "$col_AdditionalNotes TEXT,"
        "$col_Picture BLOB,"
        "$col_c1Score INTEGER,"
        "$col_c2Score INTEGER,"
        "$col_c3Score INTEGER,"
        "$col_c1Description STRING,"
        "$col_c2Description STRING,"
        "$col_c3Description STRING,"
        "$col_date,"
        "$col_isDelete BOOLEAN"
        ")";
  }


}