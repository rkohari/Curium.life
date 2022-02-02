
import 'package:curiumlife/locator.dart';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/ui/view/vgts_base_view_model.dart';

class HomePageViewModel extends  VGTSBaseViewModel
{



  logout()
  {

    print("logout called");
    preferenceService.clearData();
    navigationService.popAllAndPushNamed(Routes.login);
    notifyListeners();

  }

}