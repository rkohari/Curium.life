import 'dart:io';

import 'package:curiumlife/core/enum/camera_type.dart';
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../vgts_base_view_model.dart';

class DashboardViewModel extends VGTSBaseViewModel {
  TextEditingController searchController= new TextEditingController();

  PageController pageController = PageController();

  List<String> pageNames = ['/dashboard/home','/dashboard/report','/dashboard/outstanding','/dashboard/settings',];


  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  int marketAlertBadge = 0;

  List<bool> activeIndicators = [true,false];

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  @override
  Future onInit() {
    return super.onInit();
  }


  updateIconIndicator(int value)
  {
  print("called");
    if(value == 0)
      {
        activeIndicators[0]=true;
        activeIndicators[1]=false;
        pageController.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.elasticIn);

      }
    else
      {
        activeIndicators[0]=false;
        activeIndicators[1]=true;
        pageController.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.elasticOut);

      }
       notifyListeners();
  }


  navigateToImagePickerScreen()
  {


    pickImageFromCamera ();

  }


  bool buttonLoading =false;

  controlButtonLoading(bool value)
  {
    buttonLoading = value;
    notifyListeners();
  }

  ImagePicker picker = ImagePicker();


  pickImageFromCamera () async{
    controlButtonLoading(false);


    navigationService.pushNamed(Routes.camera);
  }


}
