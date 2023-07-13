import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_login/screen_login.dart';
import 'package:hrx_store/presentation/page_loginorsignup/widgets/widgets.dart';
import 'package:page_transition/page_transition.dart';

import '../page_signin/screen_signin.dart';

class ScreenLoginOrSignup extends StatelessWidget {
  const ScreenLoginOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight30,
              kHeight30,
              kHeight30,
              Text(
                "Welcome!",
                style:
                    TextStyle(fontSize: largeFont, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Please login or signup new account to continue",
                style: TextStyle(fontSize: 12),
              ),
              kHeight10,
              SizedBox(
                height: size.height * 0.45,
                width: size.width * 0.8,
                child: Image.asset(
                  'asset/images/shoes.png',
                  fit: BoxFit.cover,
                ),
              ),
              kHeight30,
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: ScreenLogin(),
                          type: PageTransitionType.rightToLeft));
                },
                child: const ActionButtons(
                    colr: Colors.white,
                    string: 'LOG IN',
                    stringColor: Colors.black),
              ),
              kHeight20,
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: ScreenSignin(),
                          type: PageTransitionType.rightToLeft));
                },
                child: const ActionButtons(
                  colr: Colors.black,
                  string: 'SIGN UP',
                  stringColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
