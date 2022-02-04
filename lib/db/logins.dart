import 'package:curiumlife/core/model/responce_wrapper.dart';
import 'package:curiumlife/core/model/user_model.dart';

List<UserModel> listOfUsers = [
  UserModel("1", "admin", "123456", "admin", "USR_01")
];

class LoginDatabase {
  List<UserModel> get getListOfUsers => listOfUsers;

  ResponseData validateLoginDetails(String loginId, String password) {
    print("validateLoginDetails called");
    try {

      UserModel userDB = listOfUsers.firstWhere((element) =>
          element.loginId == loginId && element.password == password);
   //   print(userDB.userType);
      return ResponseData(status: ResponceStatus.COMPLETED, data: userDB);
    } catch (e) {
       print("error gettings");
       print(e.toString());
      return ResponseData(
        status: ResponceStatus.ERROR,
      );
    }
  }





}
