import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as pathh;
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:permission_handler/permission_handler.dart';

mixin FileReaderCustomFolder {
  static String uniqFolderName = "Curium";
  String customPath = p.join("/storage/emulated/0", uniqFolderName);

  List<String> eligibleImageFileFormates = [
    ".png",
    ".tif",
    ".jpeg",
    ".jpg",
    ".bmp",
    ".eps"
  ];
  String textFileFormate = ".txt";

  Future<String> checkIsFolderExists() async {
    PermissionStatus manageExternalStoragePermission =
        await ph.Permission.manageExternalStorage.status;
    PermissionStatus storagePermission = await ph.Permission.storage.status;

    while (manageExternalStoragePermission != PermissionStatus.granted &&
        storagePermission != PermissionStatus.granted) {
      await ph.Permission.storage.request();

      await ph.Permission.manageExternalStorage.request();
      if (manageExternalStoragePermission == ph.PermissionStatus.granted &&
          storagePermission == ph.PermissionStatus.granted) break;
    }

    if (!await Directory(customPath).exists()) return await createFolder();

    Directory temp = await Directory(customPath)
      ..create(recursive: true);
    return temp.path;
  }

  Future<String> createFolder() async =>
      (await Directory(customPath).create(recursive: true)).path;

   browingCuriumFolder() async {
    List<FileSystemEntity> listOfImageUrls = [];
    List<FileSystemEntity> listOfTextFiles = [];
    Directory director = await Directory(customPath);

    List<FileSystemEntity> list = await director.listSync(recursive: true);
    list.forEach((element) {
      eligibleImageFileFormates.contains(p.extension(element.path));
      if (p.extension(element.path) == ".jpg" ||
          p.extension(element.path) == ".png" ||
          p.extension(element.path) == ".jpeg") {
        listOfImageUrls.add(element);
      }
      if (p.extension(element.path) == ".txt") {
        listOfTextFiles.add(element);
      }
    });


 return  Future.value([listOfImageUrls,listOfTextFiles]);


  }




}
