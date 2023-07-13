import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_loginorsignup/screen_logorsign.dart';
import 'package:hrx_store/presentation/page_signin/widgets/widgets.dart';
import 'package:hrx_store/services/firebase_auth/fire_base_auth.dart';
import 'package:page_transition/page_transition.dart';

import '../comman_widgets/common_widgets.dart';

// ignore: must_be_immutable
class ScreenSignin extends StatelessWidget {
  ScreenSignin({super.key});

  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: const ScreenLoginOrSignup(),
                            type: PageTransitionType.leftToRight));
                  },
                  icon: Icon(
                    Icons.arrow_circle_left_rounded,
                    size: largeFont,
                    color: Colors.black,
                  ),
                ),
                kHeight30,
                kHeight30,
                Text(
                  "Sign In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: largeFont),
                ),
                const Text(
                  "Create a new account",
                  style: TextStyle(fontSize: 12),
                ),
                kHeight30,
                kHeight30,
                TextFormFeildSignin(
                    hiniText: 'John',
                    controller: userNameController,
                    title: 'Username'),
                kHeight30,
                TextFormFeildSignin(
                  controller: emailController,
                  title: 'Email Id',
                  hiniText: 'eg: johnsmith@gmail.com',
                  emailValidation: true,
                ),
                kHeight30,
                TextFormFeildSignin(
                  controller: passwordController,
                  title: 'Password',
                  hiniText: 'eg: @johnsmith8567',
                  passwordVisibility: true,
                  trailIcon1: Icons.visibility,
                  trailIcon2: Icons.visibility_off,
                  isPasswordLength: true,
                ),
                kHeight30,
                kHeight30,
                InkWell(
                  onTap: () {
                    if (passwordController.text.isEmpty ||
                        userNameController.text.isEmpty ||
                        emailController.text.isEmpty) {
                      showSnackbar('All fields are required', context);
                    } else if (passwordController.text.length < 6) {
                      showSnackbar(
                          'Password must contain more than 6 letters', context);
                    } else {
                      FirebaseAuthentication.signUp(
                          context: context,
                          formKey: _formKey,
                          emailController: emailController,
                          userNameController: userNameController,
                          passwordController: passwordController);
                    }
                  },
                  child: const ActionButtons(
                      colr: Colors.black,
                      string: 'SIGN IN',
                      stringColor: Colors.white),
                ),
                kHeight10,
                const HaveAccount(),
                kHeight20,
                const Center(child: Text('• or sign up with •')),
                kHeight20,
                const GoogleSignUpButton()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
