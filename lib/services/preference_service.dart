

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PreferenceService {
  static const String passCode = "passCode";
  static const String userName = "USERNAME";
  static const String shopName = "SHOPNAME";
  static const String is_authed = "ISAUTHED";
  static const String appVersion = "APPVERSION";
  static const String delivery_location = "DELIVERY_LOCATION";
  static const String recent_search_location = "RECENT_SEARCH_LOCATION";
  static const String recent_search = "RECENT_SEARCH";
  static const String cart = "CART";
  static const String user = "USER";
  static const String activeorganizationId = "ACTIVE_organization_ID";
  static const String backUpDate = "backUpDate";
  static const String remote_config = "remote_config";

  static const String estimationPrefix = "estimationPrefix";
  static const String invoicePrefix = "invoicePrefix";
  static const String invoiceNumber = "invoiceNumber";
  static const String estimationNumber = "EstimationNumber";
  static const String companyName= "CompanyName";

  late SharedPreferences pref;

  init() async {
    pref = await SharedPreferences.getInstance();
  }

  setPassCode(String value) {
    pref.setString(passCode, value);
    debugPrint("Pass Code stored successfully");
  }

  setUserName(String value) async {
    pref.setString(userName, value);
    debugPrint("Name  stored successfully");
  }

  setShopName(String value) async {
    pref.setString(userName, value);
    debugPrint("ShopName  stored successfully");
  }

  setActiveorganizationId(int value) async {
    pref.setInt(activeorganizationId, value);
    debugPrint("Active organization Id stored successfully");
  }

  setCompanyName(String value) async {
    pref.setString(companyName, value);
    debugPrint("Company Name stored successfully");
  }

  setInvoicePrefix(String value) async {
    pref.setString(invoicePrefix, value);
    debugPrint("invoicePrefix stored successfully");
  }
  setEstimationPrefix(String value) async {
    pref.setString(estimationPrefix, value);
    debugPrint("estimationPrefix stored successfully");
  }

  setInvoiceNumber(int value) async {
    pref.setInt(invoiceNumber, value);
    debugPrint("invoiceNumber stored successfully");
  }

  setEstimationNumber(int value) async {
    pref.setInt(estimationNumber, value);
    debugPrint("estimationNumber stored successfully");
  }

  setAuthenticated(bool value) async {
    pref.setBool(is_authed, value);
    debugPrint("Is Authed stored successfully");
  }

  setAppVersion(String value) async {
    pref.setString(appVersion, value);
    debugPrint("Is AppVersion stored successfully");
  }

  setbackUpDate(String value) async {
    pref.setString(backUpDate, value);
    debugPrint("Is BackUpDate stored successfully");
  }

  setRemoteConfig(String value) async {
    Map json = jsonDecode(value);
    pref.setString(remote_config, user);
    debugPrint("Is Remote Config stored successfully");
  }


  String getShopName() {
    return pref.getString(shopName) ?? "";
  }
  String getAppVersion() {
    return pref.getString(appVersion) ?? "";
  }

  String getName() {
    return pref.getString(userName) ?? "";
  }

  int getActiveorganizationId() {
    return pref.getInt(activeorganizationId) ?? 0;
  }

  String getBackUpDate(){
    return pref.getString(backUpDate) ?? "";
  }

  clearData() async {
    pref.clear();
  }

}
