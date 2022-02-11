import 'package:curiumlife/core/model/table_model/patient_info_model.dart';
import 'package:curiumlife/db/base_table.dart';
import 'package:curiumlife/db/logins.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:vgts_plugin/form/utils/form_field_controller.dart';

class SearchViewModel extends VGTSBaseViewModel {
  TextFormFieldController searchController = TextFormFieldController(
      const ValueKey("searchController"),
      requiredText: "Search patient",
      required: true);

  List<PatientModel> searchResults = [];

  getSearchResults() async {
    print("called get results");
    searchResults!.clear();
    List<PatientModel> a = await BaseTable<PatientModel>().getAll();

    List<PatientModel> b = a
        .where((element) =>
            element.userUnique_id ==
            LoginDatabase()
                .getListOfUsers
                .firstWhere((element) =>
                    element.token == preferenceService.getPassCode())
                .uniqID)
        .toList();

    searchResults = b
        .where((element) =>
            element.patientName!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            element.diagoonsis!
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
        .toList();

    print(searchResults!.length);
    notifyListeners();
  }
}
