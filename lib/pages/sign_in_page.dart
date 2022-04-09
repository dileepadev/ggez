import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggez/theme/widgets/ggez_logo.dart';
import '../services/page_navigation.dart';
import '../services/validation.dart';
import '../theme/app_theme.dart';
import '../services/firebase_auth_service.dart';
import '../theme/widgets/cw_elevatedbutton.dart';
import '../theme/widgets/cw_message_popups.dart';
import '../theme/widgets/cw_text.dart';
import '../theme/widgets/cw_textbutton.dart';
import '../theme/widgets/cw_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  String errorMessage = 'No Error Message';
  bool isLoading = false;

  // --------------------------- SignIn ---------------------------
  Future _firebaseSignIn() async {
    setState(() {
      isLoading = true;
      CWMessagePopups(message: "Sign In to the account")
          .cwAlertDialogLoading(context, isLoading, "", () {
        Navigator.pop(context);
      }, 'assets/icons/icons8_info_50px.png');
    });

    User? result = await FirebaseAuthService().firebaseSignIn(
        _emailEditingController.text, _passwordEditingController.text, context);

    if (result != null) {
      debugPrint("------------ !!! User SignIn - SUCCESS ------------");
      PageNavigation(context).goToBottomNavigationTabPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    void signInButton() async {
      if (Validation().isSignInValidated(
          context, _emailEditingController, _passwordEditingController)) {
        debugPrint("Sign Up Pressed!!!");
        debugPrint("Email: ${_emailEditingController.text}");
        debugPrint("Password: ${_passwordEditingController.text}");

        debugPrint("------------ ... Start to SignUp User ------------");
        await _firebaseSignIn();
      }
    }

    Widget signInForm() {
      return Container(
        height: 400.0,
        decoration: const BoxDecoration(
          color: AppThemeData.appColorDark,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CWText(
                      textName: 'Sign In',
                      textStyle: 'headline3SemiBold',
                      textColor: AppThemeData.appColorWhite,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: const SizedBox(
                          width: 60.0,
                          child: GgezLogoImage()),
                      onTap: () {
                        PageNavigation(context).goToIntroPage();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CWTextField(
                  labelText: "Email",
                  hintText: "Enter your email",
                  isPassword: false,
                  textEditingController: _emailEditingController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                CWTextField(
                  labelText: "Password",
                  hintText: "Enter your password",
                  isPassword: true,
                  textEditingController: _passwordEditingController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CWElevatedButton(
                    buttonName: "Sign In",
                    onPressed: signInButton,
                    buttonBackgroundColor: AppThemeData.appColorRed),
                const SizedBox(
                  height: 20.0,
                ),
                CWTextButton(
                    buttonName: "New User?  Sign Up",
                    textColor: AppThemeData.appColorWhite,
                    onPressed: PageNavigation(context).goToSignUpPage),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      // appBar: CWIntroAppBar(appBarTitle: 'Sign In', onPressed: goToIntroPage)
      //     .appBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signin_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: signInForm(),
            ),
          ),
        ],
      ),
    );
  }
}
