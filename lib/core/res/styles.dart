
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'fontsize.dart';

class AppStyle {

  static const String fontFamily = "Inter";

  static final ThemeData appTheme = ThemeData(
    primaryColor: AppColor.primary,
    primaryColorDark: AppColor.primary,
    dividerColor: AppColor.outline,
    indicatorColor: AppColor.primary,
    backgroundColor: AppColor.background,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AppColor.surface,
    appBarTheme: const AppBarTheme(
      color: AppColor.background,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColor.primary, size: 24),
      centerTitle: true,
      titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColor.textOnPrimary,
          letterSpacing: 0.1
      )
    )
  );

  static final List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black.withOpacity(0.08), spreadRadius:0, blurRadius:4),
  ];

  static const Widget customDivider = SizedBox(height: 1, child: Divider(color: AppColor.outline, thickness:1.2,),);


  static Decoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  );

  static final List<BoxShadow> mildCardShadow = [
    BoxShadow(color: AppColor.secondary.withOpacity(0.2), spreadRadius: 0.5, blurRadius: 1),
  ];

  static List<Shadow> textShadow = <Shadow>[
    const Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 3.0,
      color: Colors.black12,
    ),
    const Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 8.0,
      color: Colors.black12,
    ),
  ];

}

class AppTextStyle {
  //
  // static TextStyle headline1 = const TextStyle(
  //   fontSize: 102,
  //   fontWeight: FontWeight.w300,
  //   color: AppColor.textOnPrimary,
  //   letterSpacing: -1.5
  // );
  //
  // static TextStyle headline2 = const TextStyle(
  //     fontSize: 64,
  //     fontWeight: FontWeight.w300,
  //     color: AppColor.textOnPrimary,
  //     letterSpacing: -0.5
  // );
  //
  // static TextStyle headline3 = const TextStyle(
  //     fontSize: 51,
  //     fontWeight: FontWeight.w400,
  //     color: AppColor.textOnPrimary,
  // );
  //
  // static TextStyle headline4 = const TextStyle(
  //   fontSize: 36,
  //   fontWeight: FontWeight.w400,
  //   color: AppColor.textOnPrimary,
  //   letterSpacing: 0.25
  // );
  //
  // static TextStyle headline5 = const TextStyle(
  //     fontSize: 25,
  //     fontWeight: FontWeight.w600,
  //     color: AppColor.textOnPrimary,
  // );
  //
  // static TextStyle headline6 = const TextStyle(
  //   fontSize: 21,
  //   fontWeight: FontWeight.w500,
  //   color: AppColor.textOnPrimary,
  //   letterSpacing: 0.15
  // );
  //
  // // dialob box
  // static TextStyle subtitle1 = const TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.w400,
  //     color: AppColor.textOnPrimary,
  //     letterSpacing: 0.15
  // );
  //
  //
  // static TextStyle subtitle2 = const TextStyle(
  //     fontSize: 15,
  //     fontWeight: FontWeight.w500,
  //     color: AppColor.textOnPrimary,
  //     letterSpacing: 0.1
  // );
  //
  // static TextStyle bodyText1 = const TextStyle(
  //     fontSize: 17,
  //     fontWeight: FontWeight.w500,
  //     color: AppColor.textOnPrimary,
  //     letterSpacing: 0.5
  // );
  //
  // static TextStyle bodyText2 = const TextStyle(
  //     fontSize: 15,
  //     fontWeight: FontWeight.w500,
  //     color: AppColor.textOnPrimary,
  //     letterSpacing: 0.25
  // );
  //
  // // dialog box
  // static TextStyle button = const TextStyle(
  //     fontSize: 16,
  //     fontWeight: FontWeight.w500,
  //     color: AppColor.background,
  //     letterSpacing: 1.25
  // );
  //
  // static TextStyle caption = const TextStyle(
  //     fontSize: 13,
  //     fontWeight: FontWeight.w400,
  //     color: Color(0x80000000),
  //     letterSpacing: 0.4
  // );
  //
  // static TextStyle overline = const TextStyle(
  //     fontSize: 11,
  //     fontWeight: FontWeight.w400,
  //     color: AppColor.textOnPrimary,
  //     letterSpacing: 1.5
  // );






  static TextStyle headline1 = const TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.1
  );

  static TextStyle headLine2 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.5
  );

  static TextStyle button = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.textOnPrimary,
      letterSpacing: 0.25
  );

  // dialog box
  static TextStyle subText = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColor.background,

  );

  static TextStyle subText2 = const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Color(0x80000000),
      letterSpacing: 0.4
  );

  static TextStyle overline = const TextStyle(
      fontSize: 8,
      fontWeight: FontWeight.w400,
      color: AppColor.textOnPrimary,
     // letterSpacing: 1.5
  );

}