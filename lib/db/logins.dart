import 'package:curiumlife/core/model/responce_wrapper.dart';
import 'package:curiumlife/core/model/user_model.dart';

List<UserModel> listOfUsers = [
  UserModel("1", "vgts@gmail.com", "123456", "admin", "USR_01"),
  UserModel("2", "hari@gmail.com", "123456", "admin", "USR_02")
];

class LoginDatabase {
  List<UserModel> get getListOfUsers => listOfUsers;

  ResponseData validateLoginDetails(String loginId, String password) {
    print("validateLoginDetails called");
    try {
      UserModel userDB = listOfUsers.firstWhere((element) =>
          element.loginId == loginId && element.password == password);
      return ResponseData(status: ResponceStatus.COMPLETED, data: userDB);
    } catch (e) {

      return ResponseData(
        status: ResponceStatus.ERROR,
      );
    }
  }





}
