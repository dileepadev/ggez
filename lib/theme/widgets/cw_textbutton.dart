import 'package:flutter/material.dart';

import 'cw_text.dart';

class CWTextButton extends StatelessWidget {
  const CWTextButton(
      {Key? key, required this.buttonName,required this.textColor, required this.onPressed})
      : super(key: key);

  final String buttonName;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      child: TextButton(
        child: CWText(
            textName: buttonName, textStyle: "body2SemiBold", textColor: textColor),
        onPressed: onPressed,
      ),
    );
  }
}
