import 'package:flutter/material.dart';
import './/theme/app_theme.dart';

import 'cw_text.dart';

class CWButtonFollow extends StatelessWidget {
  const CWButtonFollow(
      {Key? key, required this.isFollow, required this.onPressed})
      : super(key: key);

  final bool isFollow;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color:
                isFollow ? AppThemeData.appColorGrey : AppThemeData.appColorRed,
            borderRadius: const BorderRadius.all(
                Radius.circular(AppThemeData.appCornerRadius))),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            child: isFollow
                ? InkWell(
                    child: const CWText(
                        textName: 'Following',
                        textStyle: "body1SemiBold",
                        textColor: AppThemeData.appColorWhite),
                    onTap: onPressed,
                  )
                : InkWell(
                    child: const CWText(
                        textName: 'Follow',
                        textStyle: "body1SemiBold",
                        textColor: AppThemeData.appColorWhite),
                    onTap: onPressed,
                  )));
  }
}
