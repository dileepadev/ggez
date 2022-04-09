import 'package:flutter/material.dart';
import 'package:ggez/services/page_navigation.dart';
import 'package:ggez/theme/widgets/ggez_logo.dart';
import '../theme/app_theme.dart';
import '../theme/widgets/cw_elevatedbutton.dart';
import '../theme/widgets/cw_text.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  Widget _top() {
    return Column(
      children: const [
        CWText(
          textName: "Welcome to",
          textStyle: 'headline2SemiBold',
          textColor: AppThemeData.appColorWhite,
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(width: 200.0, child: GgezLogoImage()),
      ],
    );
  }

  Widget _bottom() {
    return Column(
      children: [
        const SizedBox(
          height: 20.0,
        ),
        CWElevatedButton(
            buttonName: "Sign In",
            onPressed: PageNavigation(context).goToSignInPage,
            buttonBackgroundColor: AppThemeData.appColorRed),
        const SizedBox(
          height: 20.0,
        ),
        CWElevatedButton(
            buttonName: "Sign Up",
            onPressed: PageNavigation(context).goToSignUpPage,
            buttonBackgroundColor: AppThemeData.appColorRed),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [_top(), _bottom()],
            ),
          ),
        ),
      ),
    );
  }
}
