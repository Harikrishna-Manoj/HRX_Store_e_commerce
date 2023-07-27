import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_loginorsignup/screen_logorsign.dart';
import 'package:page_transition/page_transition.dart';

import '../../comman_widgets/common_widgets.dart';
import '../../page_main/screen_navigationbar.dart';
import '../../page_signin/screen_signin.dart';

class PageDirection extends StatelessWidget {
  const PageDirection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            );
          } else if (snapshot.hasError) {
            return const SnackBar(content: Text('something went wrong'));
          } else if (snapshot.hasData) {
            return const VerifyEmailPage();
          } else {
            return const ScreenLoginOrSignup();
          }
        },
      ),
    );
  }
}

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sentVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  Future sentVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      showSnackbar(e.message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return isEmailVerified
        ? ScreenNavigationbar()
        : Scaffold(
            body: SafeArea(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            showSnackbar('change your email id', context);
                            Future.delayed(const Duration(seconds: 3));
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: ScreenSignin(),
                                    type: PageTransitionType.leftToRight));
                          },
                          icon: const Icon(
                            Icons.arrow_circle_left_rounded,
                            color: Colors.black,
                            size: 30,
                          )),
                      kHeight100,
                      kHeight30,
                      kHeight30,
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.green[100],
                              child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.green[200],
                                  child: Icon(
                                    Icons.mail,
                                    color: Colors.green[400],
                                    size: 40,
                                  )),
                            ),
                            kHeight10,
                            const Text(
                              'Please verify your Email !',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            kHeight20,
                            const CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
