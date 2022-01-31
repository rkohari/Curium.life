import 'package:flutter/services.dart';

class InputFormatter {

  static List<TextInputFormatter> get phoneNoFormatter => [
    FilteringTextInputFormatter.digitsOnly
  ];

  static List<TextInputFormatter> get defaultFormatter => [
    FilteringTextInputFormatter.deny(new RegExp('[\\ ]')),
  ];

}