import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../vgts_base_view_model.dart';

class DashboardViewModel extends VGTSBaseViewModel {
  TextEditingController searchController= new TextEditingController();

  List<String> pageNames = ['/dashboard/home','/dashboard/report','/dashboard/outstanding','/dashboard/settings',];


  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  int marketAlertBadge = 0;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  @override
  Future onInit() {
    return super.onInit();
  }

}
