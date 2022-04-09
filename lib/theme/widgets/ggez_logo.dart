import 'package:flutter/material.dart';

import '../app_theme.dart';

class GgezLogo extends StatelessWidget {
  const GgezLogo({Key? key}) : super(key: key);

  // CWText(
  // textName: AboutApp().appName,
  // textStyle: 'body1SemiBold',
  // textColor: AppThemeData.appColorWhite);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'G',
        style: TextStyle(
            fontFamily: 'Poppins',
            color: AppThemeData.appColorWhite,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
              text: 'g',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppThemeData.appColorRed,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          TextSpan(
            text: 'ez',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: AppThemeData.appColorWhite,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class GgezLogoDark extends StatelessWidget {
  const GgezLogoDark({Key? key}) : super(key: key);

  // CWText(
  // textName: AboutApp().appName,
  // textStyle: 'body1SemiBold',
  // textColor: AppThemeData.appColorWhite);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'G',
        style: TextStyle(
            fontFamily: 'Poppins',
            color: AppThemeData.appColorDark,
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
              text: 'g',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppThemeData.appColorRed,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
          TextSpan(
            text: 'ez',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: AppThemeData.appColorDark,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class GgezLogoHeader extends StatelessWidget {
  const GgezLogoHeader({Key? key}) : super(key: key);

  // CWText(
  // textName: AboutApp().appName,
  // textStyle: 'body1SemiBold',
  // textColor: AppThemeData.appColorWhite);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'G',
        style: TextStyle(
            fontFamily: 'Poppins',
            color: AppThemeData.appColorWhite,
            fontSize: 60.0,
            fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
              text: 'g',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppThemeData.appColorRed,
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold)),
          TextSpan(
            text: 'ez',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: AppThemeData.appColorWhite,
                fontSize: 60.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class GgezLogoImage extends StatelessWidget {
  const GgezLogoImage({Key? key}) : super(key: key);

  // CWText(
  // textName: AboutApp().appName,
  // textStyle: 'body1SemiBold',
  // textColor: AppThemeData.appColorWhite);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/app_logo_letters.png');
  }
}
