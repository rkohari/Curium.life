
import 'dart:convert';

import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/core/model/user_model.dart';
import 'package:curiumlife/services/preference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

abstract class VGTSBaseViewModel extends BaseViewModel {

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  final PreferenceService preferenceService = locator<PreferenceService>();


  // default values
  final containerWidth = 269.0;
  final containerHeight = 100.0;
  final  isAnimated =false;
  final iconSize = 26.0;

 late  UserModel userModel ;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  updateUserModel(UserModel userModel)
  {
    this.userModel=  userModel;
    print(userModel.userType);
    notifyListeners();
  }

  VGTSBaseViewModel() {
    this.onInit();
  }

  @protected
  @mustCallSuper
  Future onInit() async {
    return true;
  }

  void dispose() => super.dispose();

  void handleException()=> debugPrint("HANDLE EXCEPTION");




}
