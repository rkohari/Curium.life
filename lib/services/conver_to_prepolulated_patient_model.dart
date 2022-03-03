

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/curium_data.dart';
import 'package:curiumlife/services/image_converter.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:mock_data/mock_data.dart' as mock;


class ConvertToPrePopulatedPatientModel
{

  Random random = Random();


  Future<PatientModel> convertToClassObject({required FileSystemEntity imgeFile,required FileSystemEntity textFile})
  async{
    File file = await File(imgeFile.path);
    String uniqId = getUuid;
    String tempDate =dateFormatedData;

    List<String> ? tempType =  ["Male","Female"];
    tempType.shuffle();

    String content = await extractContentFromTxtFile(textFile);

    Uint8List ? image = await ImageConverter.testCompressFile(file);

    return  PatientModel(

      userUnique_id: "1",
      patientUniqID: uniqId,

      cvscScore: int.parse(content[0]) + int.parse(content[1]) + int.parse(content[2]),
      c1Score: int.parse(content[0]),
      c2Score: int.parse(content[1]),
      c3Score: int.parse(content[2]),
      picture: image,
      c1Description: CuriumLife().c1[int.parse(content[0])],
      c2Description:  CuriumLife().c2[int.parse(content[1])],
      c3Description:  CuriumLife().c3[int.parse(content[2])],
      date:  tempDate,
      patientName :mock.mockName("male"),
      patientAge : random.nextInt(80),
      sexType : tempType.first ,
      diagoonsis : mock.mockString(40),
      surgeryDetails : mock.mockString(100),
      additionalNotes : mock.mockString(200),
      isDelete: true,
    );
  }


  // generates a uuid
    get getUuid  => Uuid().v1();

  // generate a data

   get dateFormatedData => (DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now())).toString();


  Future<String> extractContentFromTxtFile(FileSystemEntity textFile)
   async{
     final _myFile = File(textFile.path);
     String content = await  _myFile.readAsString();
     content.trim();
     return content;
   }
}