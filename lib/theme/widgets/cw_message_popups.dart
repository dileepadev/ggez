import 'package:flutter/material.dart';

import '../app_theme.dart';
import 'cw_circular_progress_indicator.dart';
import 'cw_text.dart';
import 'cw_textbutton.dart';

class CWMessagePopups {
  CWMessagePopups({required this.message});

  final String message;

  cwSnackbar(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: AppThemeData.appColorDark,
        content: CWText(
            textName: message,
            textStyle: "subtitle",
            textColor: AppThemeData.appColorLightGrey)));
  }

  cwAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sign Up Failed'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  cwAlertDialogLoading(BuildContext context, bool isLoading, String bodyMessage,
      VoidCallback onPressed, String image) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Center(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isLoading
                      ? Image.asset(
                          image,
                          height: 25.0,
                          width: 25.0,
                        )
                      : Image.asset(
                          image,
                          height: 25.0,
                          width: 25.0,
                        ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  CWText(
                      textName: message,
                      textStyle: 'body2',
                      textColor: AppThemeData.appColorWhite),
                ],
              )),
              content: isLoading
                  ? Container(
                      height: 80.0,
                      alignment: Alignment.topCenter,
                      child: const Center(
                        child: CWCircularProgressIndicator(),
                      ))
                  : SizedBox(
                      height: 120.0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CWText(
                                textName: bodyMessage,
                                textStyle: 'body2',
                                textColor: AppThemeData.appColorWhite),
                            CWTextButton(
                                buttonName: "OK",
                                textColor: AppThemeData.appColorWhite,
                                onPressed: onPressed)
                          ],
                        ),
                      )),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
            );
          },
        );
      },
    );
  }
}
