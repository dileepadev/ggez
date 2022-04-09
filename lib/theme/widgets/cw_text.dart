import 'package:flutter/material.dart';

class CWText extends StatelessWidget {
  const CWText(
      {Key? key,
      required this.textName,
      required this.textStyle,
      required this.textColor})
      : super(key: key);

  final String textName, textStyle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    //  NAME        SIZE
    //  headline1   32.0
    //  headline2   30.0
    //  headline3   28.0
    //  headline4   26.0
    //  headline5   24.0
    //  headline6   22.0
    //  subtitle1   20.0
    //  subtitle1   18.0
    //  body1       16.0
    //  body2       14.0
    //  caption1    12.0
    //  caption2    10.0
    //  overLine1    8.0
    //  overLine2    6.0

    TextStyle headline1 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 32.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle headline1Bold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 32.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: textColor);

    TextStyle headline2 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 30.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle headline2SemiBold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 30.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: textColor);

    TextStyle headline3 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle headline3SemiBold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 28.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: textColor);

    TextStyle headline4 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 26.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle headline4Bold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 26.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: textColor);

    TextStyle headline5 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle headline5SemiBoldItalic = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24.0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        color: textColor);

    TextStyle headline5SemiBold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 24.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: textColor);

    TextStyle headline6 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 22.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle subtitle1 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle subtitle1SemiBold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: textColor);

    TextStyle subtitle1Bold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: textColor);

    TextStyle subtitle2 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle subtitle2SemiBold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: textColor);

    TextStyle body1 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle body1SemiBold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: textColor);

    TextStyle body1Bold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: textColor);

    TextStyle body2 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle body2SemiBold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: textColor);

    TextStyle body2Bold = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        color: textColor);

    TextStyle caption1 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle caption2 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 10.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle overLine1 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 8.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle overLine2 = TextStyle(
        fontFamily: 'Poppins',
        fontSize: 6.0,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: textColor);

    TextStyle setCustomTextStyle(String textType) {
      if (textType == "headline1") {
        return headline1;
      } else if (textType == "headline1Bold") {
        return headline1Bold;
      } else if (textType == "headline2") {
        return headline2;
      } else if (textType == "headline2SemiBold") {
        return headline2SemiBold;
      } else if (textType == "headline3") {
        return headline3;
      } else if (textType == "headline3SemiBold") {
        return headline3SemiBold;
      } else if (textType == "headline4") {
        return headline4;
      } else if (textType == "headline4Bold") {
        return headline4Bold;
      } else if (textType == "headline5SemiBoldItalic") {
        return headline5SemiBoldItalic;
      } else if (textType == "headline5") {
        return headline5;
      } else if (textType == "headline5SemiBold") {
        return headline5SemiBold;
      } else if (textType == "headline6") {
        return headline6;
      } else if (textType == "subtitle1") {
        return subtitle1;
      } else if (textType == "subtitle1SemiBold") {
        return subtitle1SemiBold;
      } else if (textType == "subtitle1Bold") {
        return subtitle1Bold;
      } else if (textType == "subtitle2") {
        return subtitle2;
      } else if (textType == "subtitle2SemiBold") {
        return subtitle2SemiBold;
      } else if (textType == "body1") {
        return body1;
      } else if (textType == "body1SemiBold") {
        return body1SemiBold;
      } else if (textType == "body1Bold") {
        return body1Bold;
      } else if (textType == "body2") {
        return body2;
      } else if (textType == "body2SemiBold") {
        return body2SemiBold;
      } else if (textType == "body2Bold") {
        return body2Bold;
      } else if (textType == "caption1") {
        return caption1;
      } else if (textType == "caption2") {
        return caption2;
      } else if (textType == "overLine1") {
        return overLine1;
      } else if (textType == "overLine2") {
        return overLine2;
      } else {
        return body1;
      }
    }

    return Text(textName, style: setCustomTextStyle(textStyle));
  }
}
