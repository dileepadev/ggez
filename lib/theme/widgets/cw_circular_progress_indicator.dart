import 'package:flutter/material.dart';
import 'package:ggez/theme/app_theme.dart';

class CWCircularProgressIndicator extends StatelessWidget {
  const CWCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppThemeData.appColorRed,
    );
  }
}
