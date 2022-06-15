import 'package:flutter/material.dart';

class AppThemeData {
  static const appColorDark = Color.fromRGBO(23, 23, 23, 1.0);
  static const appColorRed = Color.fromRGBO(218, 0, 55, 1.0);
  static const appColorDarkGrey = Color.fromRGBO(50, 50, 50, 1.0);
  static const appColorLightGrey = Color.fromRGBO(168, 168, 168, 1.0);

  static Color appColorDarkWithOpacity = Colors.black.withOpacity(0.1);

  static const appColorGrey = Color.fromRGBO(68, 68, 68, 1.0);
  static const appColorMediumGrey = Color.fromRGBO(108, 108, 108, 1.0);
  static const appColorWhite = Color.fromRGBO(237, 237, 237, 1.0);
  static const pureColorWhite = Color.fromARGB(255, 255, 255, 255);

  static const userColorNewUser = Color.fromARGB(255, 226, 198, 15);
  static const userColorLevelOne = Color.fromARGB(255, 11, 90, 151);
  static const userColorLevelTwo = Color.fromRGBO(218, 0, 55, 1.0);

  static const double appCornerRadius = 20.0;

  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    primaryColor: appColorDark,
    backgroundColor: appColorRed,
    scaffoldBackgroundColor: pureColorWhite,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(color: appColorRed, elevation: 0.0),
    iconTheme: const IconThemeData(color: appColorDark),
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      headline3: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      headline4: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
      headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      subtitle2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      caption: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      overline: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.red,
      selectionColor: Colors.green,
      selectionHandleColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(appColorDark),
        foregroundColor: MaterialStateProperty.all<Color>(appColorWhite),
      ),
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    primaryColor: appColorDark,
    backgroundColor: appColorRed,
    scaffoldBackgroundColor: appColorDark,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(color: appColorRed, elevation: 0.0),
    iconTheme: const IconThemeData(color: appColorWhite),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppThemeData.appColorRed,
      selectionColor: AppThemeData.appColorLightGrey,
      selectionHandleColor: AppThemeData.appColorRed,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(appColorDark),
        foregroundColor: MaterialStateProperty.all<Color>(appColorWhite),
      ),
    ),
  );
}
