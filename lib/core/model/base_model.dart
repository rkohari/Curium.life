
import 'package:vgts_plugin/form/base_object.dart';

class BaseModel extends BaseObject {

  BaseModel();

  BaseModel fromJson(Map<String, dynamic> json) {
    throw("fromJson not implemented");
  }

  Map<String, dynamic> toJson(){
    throw("toJson not implemented");
  }

  Map<String, dynamic> toRequestParam(){
    throw("toRequestParam not implemented. Please check the modal object");
  }

  Object get key {
    throw ("Get Key not defined");
  }

  String get text {
    return this.runtimeType.toString();
  }

  bool operator == (Object other) {
    if (identical(this, other))
      return true;

    if (other is BaseModel) {
      return this.text == other.text;
    }
    return false;
  }

  String toString() {
    return toJson().toString();
  }

  static T object<T extends BaseModel>() {
    switch (T) {
      // case ChitMaster:
      //   return ChitMaster() as T;

    }
    throw "Requested Model not initialised in Base Model";
  }

  static createFromMap<T extends BaseModel>(Map<String, dynamic> data) {
    return object<T>().fromJson(data);
  }

}
