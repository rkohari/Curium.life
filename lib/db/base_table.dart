import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/patient_info_constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vgts_plugin/form/base_object.dart';

import '../locator.dart';
import '../services/preference_service.dart';
import 'database_service.dart';
import 'master_database_service.dart';


 class BaseTable<T extends BaseDBModel> {

  final PreferenceService _preferenceService = locator<PreferenceService>();

  int get organizationId => _preferenceService.getActiveorganizationId();

  final deleted = null;


  Database get _masterDatabase => locator<MasterDatabaseService>().database;

  T get object => BaseDBModel.object<T>();




  Future<List<P>> rawQuery<P extends BaseDBModel>(String query) async {
    List<Map> list = [];

    Database database = _masterDatabase  ;

    print(database.toString());

    list = await database.rawQuery(query);
   // List<P> dataList = await Future.wait(list.map((e) => BaseDBModel.createFromMap<P>(e)).toList());
    //return dataList;
    return [];
  }


  Future<List<T>> getAll() async {
    List<Map<String, dynamic>> list = [];
    // String whereQueryString = whereQuery;

    Database database =  _masterDatabase;

    list = await database.query(object.tableName,);
    print("the list is ${list}");

    List<T> dataList = await Future.wait(list.map((e) => BaseDBModel.createFromMap<T>(e)).toList());
    print("the dataList is ${dataList.length}");

    return dataList;
  }

  Future<T?> getById(int id ,) async {
    if(id == null) {
      return null;}
    else {

      Database database =  _masterDatabase  ;
     // List<Map> data = await database.query(object.tableName, where: "${whereQuery} ${whereQuery.isNotEmpty ? "AND" : " "}  ${object.primaryKey} = ? ", whereArgs: [ ...whereArgsList, id]);
     //  if (data.length <= 0) {
     //    return null;
     //  }
     //  print("data.length${data.length}");

    }
  }

  Future<int> insert(T data, ) async {


    Database database =  _masterDatabase  ;
    print("table going to insterted");

    int result = await database.insert(object.tableName, data.toDatabaseMap());
    print("table 200 insterted");
    return result;
  }


  Future<int> update(String id, T data, ) async {

    print(id);

    Database database = _masterDatabase  ;

    int result = await database.update(object.tableName, data.toDatabaseMap(), where: "${object.primaryKey}");
    return result;
  }

  Future<int> delete(int id , T data ,{bool fromMasterTable = false}) async {


    Database database =  _masterDatabase  ;

    // Map param = data.toDatabaseMap();
    // param[BaseConstant().col_deleted] = true;
    // int result = await database.update(object.tableName, param, where: "${object.primaryKey} = ?", whereArgs: [id],);
     return 1;
  }

  get masterTransaction => _masterDatabase.transaction;

}



class BaseConstant extends BaseDBModel {

  final String col_organization_id ='organization_id';
  final String col_status ='status';
  final String col_deleted ='deleted';
  final String col_created_at_time ='created_at_time';
  final String col_updated_at_time ='updated_at_time';
  final String col_deleted_at_time ='deleted_at_time';

}

class BaseDBModel extends BaseObject {

  String? _tableName;
  String? _primaryKey;

  String get tableName {
   if (_tableName == null){
     throw "Missing Table Name. Please Configure In your model class by overriding tableName variable";
   }
   print("table name is ${_tableName}");
   return _tableName!;
  }

  String get primaryKey {
    if (_primaryKey == null){
      throw "Missing Primary Key. Please Configure In your model class by overriding tableName variable";
    }
    return _primaryKey!;
  }

  set tableName(String value) {
    _tableName = value;
  }

  set primaryKey(String value) {
    _primaryKey = value;
  }

  static T object<T extends BaseDBModel>() {
    switch (T) {
       case PatientModel:
         return PatientModel() as T;
    }
    throw "Requested Model not initialised in Base Model";
  }

  static Future<T> createFromMap<T extends BaseDBModel>(Map<String, dynamic> data) async {
    return await object<T>().fromMap(data);
  }

}
