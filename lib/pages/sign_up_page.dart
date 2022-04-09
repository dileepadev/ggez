import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/widgets/ggez_logo.dart';
import './/services/page_navigation.dart';
import './/theme/app_theme.dart';
import '../services/validation.dart';
import '../services/firebase_auth_service.dart';
import '../services/firebase_firestore_service.dart';
import '../theme/widgets/cw_message_popups.dart';
import '../theme/widgets/cw_elevatedbutton.dart';
import '../theme/widgets/cw_text.dart';
import '../theme/widgets/cw_textbutton.dart';
import '../theme/widgets/cw_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();

  String errorMessage = 'No Error Message';
  bool isLoading = false;

  // --------------------------- SignUp ---------------------------
  Future _firebaseSignUp() async {
    setState(() {
      isLoading = true;
      CWMessagePopups(message: "Creating Account")
          .cwAlertDialogLoading(context, isLoading, "", () {
        Navigator.pop(context);
      }, 'assets/icons/icons8_info_50px.png');
    });

    User? result = await FirebaseAuthService().firebaseSignUp(
        _emailEditingController.text, _passwordEditingController.text, context);

    if (result != null) {
      debugPrint("------------ !!! User SignUp - SUCCESS ------------");
      debugPrint("------------ ... Start Add User to Firebase ------------");
      FirebaseFirestoreService().firebaseAddUserToFirestore(
          _emailEditingController.text,
          _passwordEditingController.text,
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    void signUpButton() async {
      if (Validation().isSignUpValidated(context, _emailEditingController,
          _passwordEditingController, _confirmPasswordEditingController)) {
        debugPrint("Sign Up Pressed!!!");
        debugPrint("Email: ${_emailEditingController.text}");
        debugPrint("Password: ${_passwordEditingController.text}");
        debugPrint(
            "Confirm Password: ${_confirmPasswordEditingController.text}");

        debugPrint("------------ ... Start to SignUp User ------------");
        await _firebaseSignUp();
      }
    }

    Widget signUpForm() {
      return Container(
        height: 475.0,
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
                      textName: 'Sign Up',
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
                  height: 5.0,
                ),
                CWTextField(
                  labelText: "Confirm Password",
                  hintText: "Confirm your password",
                  isPassword: true,
                  textEditingController: _confirmPasswordEditingController,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CWElevatedButton(
                    buttonName: "Sign Up",
                    onPressed: signUpButton,
                    buttonBackgroundColor: AppThemeData.appColorRed),
                const SizedBox(
                  height: 20.0,
                ),
                CWTextButton(
                    buttonName: "Already User?  Sign In",
                    textColor: AppThemeData.appColorWhite,
                    onPressed: PageNavigation(context).goToSignInPage),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      // appBar: CWIntroAppBar(appBarTitle: 'Sign Up', onPressed: goToIntroPage)
      //     .appBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/signup_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: signUpForm(),
            ),
          ),
        ],
      ),
    );
  }
}
