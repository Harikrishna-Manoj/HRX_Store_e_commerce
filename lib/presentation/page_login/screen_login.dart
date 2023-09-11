import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_login/widgets/widget.dart';
import 'package:hrx_store/presentation/page_loginorsignup/screen_logorsign.dart';

import '../../services/firebase_auth/fire_base_auth.dart';
import '../comman_widgets/common_widgets.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final _formKey = GlobalKey<FormState>();
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
                const BackNavigationButton(page: ScreenLoginOrSignup()),
                kHeight30,
                kHeight30,
                Text(
                  "Log In",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: largeFont),
                ),
                const Text(
                  "Please login to continue",
                  style: TextStyle(fontSize: 12),
                ),
                kHeight30,
                kHeight30,
                TextFormFeildLogin(
                  controller: emailController,
                  title: 'Email Id',
                  hiniText: 'eg: johnsmith@gmail.com',
                  emailValidation: true,
                ),
                kHeight30,
                TextFormFeildLogin(
                  controller: passwordController,
                  title: 'Password',
                  hiniText: 'eg: @johnsmith8567',
                  passwordVisibility: true,
                  trailIcon1: Icons.visibility,
                  trailIcon2: Icons.visibility_off,
                  isPasswordLength: true,
                ),
                kHeight100,
                kHeight10,
                InkWell(
                  onTap: () {
                    if (passwordController.text.isEmpty ||
                        emailController.text.isEmpty) {
                      showSnackbar('All fields are required', context);
                    } else if (passwordController.text.length < 6) {
                      showSnackbar(
                          'Password must contain more than 6 letters', context);
                    } else {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailController.text)) {
                        FirebaseAuthentication.logIn(
                            context: context,
                            formKey: _formKey,
                            emailController: emailController,
                            passwordController: passwordController);
                      } else {
                        showSnackbar('Email format is incorrect', context);
                      }
                    }
                  },
                  child: const ActionButtons(
                      colr: Colors.black,
                      string: 'LOG IN',
                      stringColor: Colors.white),
                ),
                kHeight10,
                const ForgotPassword(),
                kHeight20,
                const NoAccount(),
                kHeight20,
                const GoogleLoginButton()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
