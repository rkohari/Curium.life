import 'package:curiumlife/core/model/user_model.dart';

class ResponseData {
  ResponceStatus? status;
  UserModel? data;

  ResponseData({this.status, this.data});
}

enum ResponceStatus { COMPLETED, ERROR }
