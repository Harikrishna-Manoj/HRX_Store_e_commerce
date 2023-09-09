import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hrx_store/presentation/page_login/screen_login.dart';
import 'package:hrx_store/presentation/page_main/screen_navigationbar.dart';
import 'package:hrx_store/presentation/page_splash/pagedirection/page_direction.dart';
import 'package:page_transition/page_transition.dart';
import '../../main.dart';

class FirebaseAuthentication {
  static Future signUp(
      {required BuildContext context,
      required GlobalKey<FormState> formKey,
      required TextEditingController emailController,
      required TextEditingController userNameController,
      required TextEditingController passwordController}) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = formKey;
    final isValid = _formKey.currentState?.validate();
    if (isValid == false) return;

    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );

    try {
      // print('called');
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
              child: const VerifyEmailPage(),
              type: PageTransitionType.rightToLeft),
          (Route<dynamic> route) => false);

      User currentuser = FirebaseAuth.instance.currentUser!;
      currentuser.updateDisplayName(userNameController.text);
      // ignore: use_build_context_synchronously
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      navigatorKey.currentState!.pop();
      Fluttertoast.showToast(msg: e.message.toString());
    }

    return;
  }

  static Future signInwithGoogle({required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );
    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    // ignore: use_build_context_synchronously

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      Fluttertoast.showToast(msg: 'Logged in');
      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
              child: ScreenNavigationbar(), type: PageTransitionType.fade),
          (Route<dynamic> route) => false);
    }).onError((error, stackTrace) {
      navigatorKey.currentState!.pop();
      Fluttertoast.showToast(msg: 'Error:${error.toString()}');
    });
  }

  static Future logIn(
      {required BuildContext context,
      required GlobalKey<FormState> formKey,
      required TextEditingController emailController,
      required TextEditingController passwordController}) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = formKey;
    final isValid = _formKey.currentState?.validate();
    if (isValid == false) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: 'Logged in');
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          PageTransition(
              child: ScreenNavigationbar(), type: PageTransitionType.fade),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Fluttertoast.showToast(msg: e.message.toString());
    }

    return;
  }

  static Future resetPassword({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
  }) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = formKey;
    final isValid = _formKey.currentState?.validate();
    if (isValid == false) {
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: 'Password reset link sended to the mail');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: ScreenLogin(), type: PageTransitionType.rightToLeft));
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Fluttertoast.showToast(msg: e.message.toString());
    }

    return;
  }

  static Future accountLogOut({required BuildContext context}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );
    try {
      final googleSignIn = GoogleSignIn();
      googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: 'Logged out');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          PageTransition(child: ScreenLogin(), type: PageTransitionType.fade));
    } on FirebaseAuthException catch (e) {
      navigatorKey.currentState!.pop();
      Fluttertoast.showToast(msg: e.message.toString());
    }
    return;
  }
}
