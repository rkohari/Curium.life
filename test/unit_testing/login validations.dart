import 'package:curiumlife/core/model/responce_wrapper.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:flutter_test/flutter_test.dart';

login() {
  print("*************** TRIGGERED LOGIN UNIT TESTING *****************");
  group("login validations", () {
    final loginModel = LoginDatabase();

    List<Map<String, dynamic>> loginCombinations = [
      {
        "emailId": "vgts@gmail.com",
        "password": "123456",
        "status": ResponceStatus.COMPLETED
      },
      {
        "emailId": "vgtsgmail.com",
        "password": "123456",
        "status": ResponceStatus.ERROR
      },
      {
        "emailId": "vgts@",
        "password": "123456",
        "status": ResponceStatus.ERROR
      },
      {
        "emailId": "vgts@gmail",
        "password": "123456",
        "status": ResponceStatus.ERROR
      },
      {
        "emailId": "vgts@gmail.com",
        "password": "1",
        "status": ResponceStatus.ERROR
      },
      {
        "emailId": "",
        "password": "",
        "status": ResponceStatus.ERROR
      },
      {
        "emailId": "",
        "password": "123456",
        "status": ResponceStatus.ERROR
      },
      {
        "emailId": "vgts@gmail.com",
        "password": "","status": ResponceStatus.ERROR
      },
      {
        "emailId": "           1",
        "password": "              ",
        "status": ResponceStatus.ERROR,
      }
    ];

    for (int i = 0; i < loginCombinations.length; i++) {
      test("test $i", () {
        ResponseData data = loginModel.validateLoginDetails(
            loginCombinations[i]["emailId"], loginCombinations[i]["password"]);

        expect(
          data.status,
          loginCombinations[i]["status"],
        );
      });
    }
  });
}
