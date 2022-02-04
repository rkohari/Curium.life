class UserModel {
  String? uniqID;
  String? loginId;
  String? password;
  String? userType;
  String ? token;

  UserModel(this.uniqID, this.loginId, this.password, this.userType,this.token);

  @override
  String toString() {
//
    return "$password $uniqID";
  }
}