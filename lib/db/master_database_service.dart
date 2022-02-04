import 'dart:io';
import 'package:curiumlife/db/patient_info_constant.dart';
import 'package:sqflite/sqflite.dart';
import '../locator.dart';
import 'base_database_service.dart';

class MasterDatabaseService extends BaseDatabaseService {
  static const _databaseName = "Cuirum.db";

  late Database _database;

  Database get database => _database;

  Future<Database> initialise() async {
    var databasesPath = await getDatabasesPath();

    try {
      await Directory(databasesPath).create(recursive: true);

      _database = await openDatabase(_databaseName,
          version: 1,
          // TODO: Change the version method dynamically
          onConfigure: onConfigure,
          onCreate: onCreate,
          onOpen: onOpen,
          onUpgrade: onUpgrade);

      return _database;
    } catch (_) {
      //TODO: Database Service Need to add handler for exception
      exit(1);
    }

    //return null;
  }

  @override
  Future<void> onConfigure(Database db) async {}

  @override
  Future<void> onCreate(Database db, int version) async {
// need to create all tables
    await db.execute(CVCConstant().createQuery);

    await _insertInitData(db, version);

    await super.onCreate(db, version);
    print("Master Database Created");
  }

  Future _insertInitData(Database db, int version) async {
    // filterTypeList.forEach((element) async {
    //   await db.insert(FilterType().tableName, element.toDatabaseMap());
    // });
  }

  @override
  Future<void> onOpen(Database db) async {
    print("Master Database Already Created");
  }

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {}
}
