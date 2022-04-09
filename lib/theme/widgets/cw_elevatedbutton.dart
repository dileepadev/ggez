import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'cw_text.dart';

class CWElevatedButton extends StatelessWidget {
  const CWElevatedButton(
      {Key? key,
      required this.buttonName,
      required this.onPressed,
      required this.buttonBackgroundColor})
      : super(key: key);

  final String buttonName;
  final VoidCallback onPressed;
  final Color buttonBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: CWText(
            textName: buttonName, textStyle: "subtitle1SemiBold", textColor: AppThemeData.appColorWhite),
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonBackgroundColor),
          //foregroundColor: MaterialStateProperty.all<Color>(appColorWhite),
        ),
      ),
    );
  }
}
