
import 'package:curiumlife/ui/view/camera_screen/camera_screen.dart';
import 'package:curiumlife/ui/view/dashboard/dashboard_page.dart';
import 'package:curiumlife/ui/view/image_picker/image_info_screen.dart';
import 'package:curiumlife/ui/view/image_picker/image_preview_screen.dart';
import 'package:curiumlife/ui/view/image_picker/image_process.dart';
import 'package:curiumlife/ui/view/login/login_page.dart';
import 'package:curiumlife/ui/view/patient_info_get/patient_info_screen.dart';
import 'package:curiumlife/ui/view/splash/splash_page.dart';
import 'package:curiumlife/ui/view/status/200_screen.dart';
import 'package:curiumlife/ui/view/status/501_screen.dart';
import 'package:curiumlife/ui/view/view_patient_details/patient_details_screen.dart';
import 'package:flutter/material.dart';

import 'core/model/table_model/patient_info_model.dart';

const String initialRoute = "login";

class Routes {
  static const String splash = "/";
  static const String dashboard = "/dashboard";
  static const String login = "/auth/login";
  static const String imagePicker = "/imagePicker";
  static const String imagePreview = "/imagePreview";
  static const String imageProcess = "/imageProcess";
  static const String imageInfo = "/imageInfo";
  static const String patientInfo = "/patientInfo";
  static const String success = "/success";
  static const String failure = "/failure";
  static const String patientDetails = "/patientDetails";
  static const String camera = "/camera";

  //ErrorScreen

}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

    case Routes.splash:
      return MaterialPageRoute(
        builder: (_) => SplashPage(),
        settings: RouteSettings(name: settings.name),
      );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => LogInPage(),
          settings: RouteSettings(name: settings.name),
        );

    case Routes.dashboard:
      return MaterialPageRoute(
        builder: (_) => DashboardPage(),//settings.arguments to pass arguments
        settings: RouteSettings(name: settings.name),
      );


      case Routes.imagePreview:
        return MaterialPageRoute(
          builder: (_) => ImagePreviewScreen(settings.arguments),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );

      case Routes.imageProcess:
        return MaterialPageRoute(
          builder: (_) => ImageProcessScreen(settings.arguments),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );
      case Routes.imageInfo:
        return MaterialPageRoute(
          builder: (_) => ImageInfoScreen(settings.arguments),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );

      case Routes.patientInfo:
        return MaterialPageRoute(
          builder: (_) => PatientInfo(settings.arguments),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );

      case Routes.success:
        return MaterialPageRoute(
          builder: (_) => SuccessScreen(),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );
      case Routes.failure:
        return MaterialPageRoute(
          builder: (_) => FailureScreen(),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );

      case Routes.patientDetails:
        return MaterialPageRoute(
          builder: (_) => PatientDetails(settings.arguments as PatientModel),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );

      case Routes.camera:
        return MaterialPageRoute(
          builder: (_) => CameraScreen(),//settings.arguments to pass arguments
          settings: RouteSettings(name: settings.name),
        );

      default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        )
      );
    }
  }
}

/// NoTransitionRoute
/// Custom route which has no transitions
class NoTransitionRoute<T> extends MaterialPageRoute<T> {
  NoTransitionRoute({ required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

/// NoPushTransitionRoute
/// Custom route which has no transition when pushed, but has a pop animation
class NoPushTransitionRoute<T> extends MaterialPageRoute<T> {
  NoPushTransitionRoute({ required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // is popping
    if (animation.status == AnimationStatus.reverse) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }
    return child;
  }
}

/// NoPopTransitionRoute
/// Custom route which has no transition when popped, but has a push animation
class NoPopTransitionRoute<T> extends MaterialPageRoute<T> {
  NoPopTransitionRoute({ required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // is pushing
    if (animation.status == AnimationStatus.forward) {
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    }
    return child;
  }
}

class RouteUtils {
  static RoutePredicate withNameLike(String name) {
    return (Route<dynamic> route) {
      return !route.willHandlePopInternally &&
          route is ModalRoute &&
          route.settings.name != null &&
          route.settings.name?.contains(name) == true;
    };
  }
}