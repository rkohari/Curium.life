
import 'dart:convert';

import 'package:curiumlife/core/enum/view_state.dart';
import 'package:curiumlife/services/preference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

abstract class VGTSBaseViewModel extends BaseViewModel {

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  final PreferenceService preferenceService = locator<PreferenceService>();

  void setState(ViewState viewState) {
    _state = viewState;
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
