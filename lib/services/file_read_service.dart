import 'dart:io';

import 'package:path/path.dart' as p;
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


   collectAllFilesInsideCuriumFolder() async {
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



  Future<PermissionStatus>  checkManageExternalStoragePermissionStatus() async=>await  ph.Permission.manageExternalStorage.status;
  Future<PermissionStatus>  checkManageStoragePermissionStatus () async=> await ph.Permission.storage.status;

  requestManageExternalStorageAccess () async=> await ph.Permission.manageExternalStorage.request();

  requestStorageAccess () async => await ph.Permission.storage.request();


  folderHandling()
  async {
    if (!await Directory(customPath).exists()) return await createFolder();
    else
      return  await Directory(customPath)..create(recursive: true)..path;

  }

  Future<String> createFolder() async => (await Directory(customPath).create(recursive: true)).path;


  Future<bool> isFolderExists()
 async {
  return   await Directory(customPath).exists();
  }

  deleteAllFIlesInsideTheFolder()
  async {
    print("Delete Funtion Called");
    List<List<
        FileSystemEntity>> temp = await collectAllFilesInsideCuriumFolder();

    List<FileSystemEntity> temp1 = List.from(temp[0]);
    List<FileSystemEntity> temp2 = List.from(temp[1]);

    if (temp1.isNotEmpty) {
      temp1.forEach((element) async {
        File file = await File(element.path);
        file.delete(recursive: true);
      });
    }
    if (temp2.isNotEmpty) {
      temp2.forEach((element) async {
        File file = await File(element.path);
        file.delete(recursive: true);
      });
    }
  }
}
