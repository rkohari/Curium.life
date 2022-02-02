class LoginDatabase {
  List<UserDB> _listOfUsers = [UserDB("1", "admin", "123456", "admin","USR_01")];

  List<UserDB> get listOfUsers => _listOfUsers;

  ResponseData validateLoginDetails(String loginId, String password) {
    try {
      UserDB userDB = _listOfUsers.firstWhere((element) =>
          element.loginId == loginId && element.password == password);
      return ResponseData(status: ResponceStatus.COMPLETED, data: userDB);
    } catch (e) {
      return ResponseData(
        status: ResponceStatus.ERROR,
      );
    }
  }
}

class UserDB {
  String? uniqID;
  String? loginId;
  String? password;
  String? userType;
  String ? token;

  UserDB(this.uniqID, this.loginId, this.password, this.userType,this.token);

  @override
  String toString() {
//
    return "$password $uniqID";
  }
}

class ResponseData {
  ResponceStatus? status;
  UserDB? data;

  ResponseData({this.status, this.data});
}

enum ResponceStatus { COMPLETED, ERROR }
