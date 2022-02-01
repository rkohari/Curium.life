
import 'package:curiumlife/services/dialog_service.dart';
import 'package:curiumlife/services/navigation_service.dart';
import 'package:curiumlife/services/preference_service.dart';
import 'package:get_it/get_it.dart';

import 'db/database_service.dart';
import 'db/master_database_service.dart';
import 'ui/view/home/homepage_view_model.dart';


GetIt locator = GetIt.instance;

PreferenceService get preferenceService => locator<PreferenceService>();
NavigationService get navigationService => locator<NavigationService>();
DialogService get dialogService => locator<DialogService>();

void setupLocator() {


 // locator.registerLazySingleton(() => UpdateChecker());

  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => PreferenceService());
  locator.registerLazySingleton(() => NavigationService());

  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => MasterDatabaseService());

  locator.registerLazySingleton(() => HomePageViewModel());

}
