import 'dart:async';
import 'dart:io';
import 'package:curiumlife/router.dart';
import 'package:curiumlife/services/dialog_service.dart';
import 'package:curiumlife/services/navigation_service.dart';
import 'package:curiumlife/services/preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'core/res/styles.dart';
import 'helper/dialog_manager.dart';
import 'locator.dart';

Future<Null> main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();


  FlutterError.onError = (FlutterErrorDetails details) {
  };

  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: (Object obj, StackTrace stack) {
  });

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  final navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:Platform.isIOS ? Brightness.light : Brightness.dark
    ));

    return MultiProvider(
      providers: [
        Provider<PreferenceService>(create: (context) => locator<PreferenceService>()),
      ],
      child: MaterialApp(
        title: "Sidvi",
        theme: AppStyle.appTheme,
        builder: _setupDialogManager,
        initialRoute:  '/',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigationService.navigatorKey,
        onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
      ),
    );
  }

  Widget _setupDialogManager(context, widget) {
    return Navigator(
      key: locator<DialogService>().dialogNavigationKey,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
        final MediaQueryData data = MediaQuery.of(context);
        return DialogManager(
          child: MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: widget,
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}

