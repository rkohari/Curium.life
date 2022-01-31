import 'dart:io';

import 'package:curiumlife/services/preference_service.dart';
import 'package:sqflite/sqflite.dart';

import '../locator.dart';
import 'base_database_service.dart';

class DatabaseService extends BaseDatabaseService {

 PreferenceService preferenceService = locator<PreferenceService>();

 late Database _database;

 Database get database => _database;


 Future<Database> init() async {
  var databasesPath = await getDatabasesPath();

  try {
   await Directory(databasesPath).create(recursive: true);

   _database = await openDatabase("test.db",
       version: 1,
       // TODO: Change the version method dynamically
       onConfigure: onConfigure,
       onCreate: onCreate,
       onOpen: onOpen,
       onUpgrade: onUpgrade
   );

   return _database;
  } catch (_) {
   //TODO: Database Service Need to add handler for exception
   exit(1);
  }
 }

 @override
 Future<void> onConfigure(Database db) async {

 }

 @override
 Future<void> onCreate(Database db, int version) async {
  await super.onCreate(db, version);
 }

 @override
 Future<void> onOpen(Database db) async {

 }

 @override
 Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {

 }
}