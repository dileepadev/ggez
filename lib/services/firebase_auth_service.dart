import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggez/services/page_navigation.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../theme/widgets/cw_message_popups.dart';

class FirebaseAuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String errorMessage = 'No Error Message';
  bool isLoading = false;
  User? currentUser = FirebaseAuth.instance.currentUser;

  // --------------------------- Find Firebase Auth Error Type ---------------------------
  void findFirebaseAuthErrorType(
      FirebaseAuthException authError, BuildContext context, String type) {
    switch (authError.code) {
      case 'user-not-found':
        errorMessage =
            'There is no user record corresponding to this identifier. The user may have been deleted.';
        break;
      case 'email-already-in-use':
        errorMessage =
            'Already exists an account with the given email address.';
        break;
      case 'invalid-email':
        errorMessage = 'Email address is not valid.';
        break;
      case 'operation-not-allowed':
        errorMessage = 'Email/Password accounts are not enabled.';
        break;
      case 'wrong-password':
        errorMessage =
            'The password is invalid or the user does not have a password.';
        break;
      case 'weak-password':
        errorMessage = 'Password is not strong enough.';
        break;
      case 'network-request-failed':
        errorMessage =
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.';
        break;
      default:
        errorMessage = 'Some type of error.';
    }

    debugPrint("------------ ??? User $type - FAILED ------------");
    debugPrint("ERROR: ${authError.toString()}");
    //debugPrint(errorMessage);

    Navigator.pop(context);
    CWMessagePopups(message: "Error")
        .cwAlertDialogLoading(context, isLoading, errorMessage, () {
      Navigator.pop(context);
    }, 'assets/icons/icons8_high_priority_50px.png');
  }

  // --------------------------- Sign Up ---------------------------
  Future<User?> firebaseSignUp(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (authError) {
      findFirebaseAuthErrorType(authError, context, 'SignUp');
    }
    return null;
  }

  // --------------------------- Sign In ---------------------------
  Future<User?> firebaseSignIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (authError) {
      findFirebaseAuthErrorType(authError, context, 'SignIn');
    }
    return null;
  }

  // --------------------------- Sign Out ---------------------------
  Future firebaseSignOut(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
      PageNavigation(context).goToIntroPage();
      debugPrint("------------ !!! User Sign Out - SUCCESS ------------");
      //return true;
    } on Exception catch (firebaseError) {
      debugPrint("------------ !!! User Sign Out - FAILED ------------");
      debugPrint(firebaseError.toString());
      CWMessagePopups(message: "User Sign Out Fail").cwAlertDialogLoading(
          context, isLoading, 'Oopz.. Seems you cannot sign out!', () {
        Navigator.pop(context);
      }, 'assets/icons/icons8_high_priority_50px.png');
    }
   // return false;
  }

  // --------------------------- Sign In with Google ---------------------------
  // Future<UserCredential?> googleSignIn(BuildContext context) async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   } on FirebaseAuthException catch (authError) {
  //     findFirebaseAuthErrorType(authError, context, 'SignIn');
  //     return null;
  //   }
  // }

  // --------------------------- Verify Email ---------------------------
  Future<bool?> verifyEmail() async {
    if (currentUser != null && !currentUser!.emailVerified) {
      await currentUser!.sendEmailVerification();
      return true;
    }
    return false;
  }

  bool isUserEmailVerified() {
    if (currentUser != null && !currentUser!.emailVerified) {
      //await currentUser!.sendEmailVerification();
      return false;
    }
    return true;
  }
}
