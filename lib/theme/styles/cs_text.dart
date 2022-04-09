import 'package:flutter/material.dart';
import '../app_theme.dart';

class CSText {
  TextStyle textFieldLabelDark = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: AppThemeData.appColorDark);

  TextStyle textFieldLabelLightGrey = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: AppThemeData.appColorLightGrey);

  TextStyle textFieldLabelLight = const TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: AppThemeData.appColorWhite);
}
