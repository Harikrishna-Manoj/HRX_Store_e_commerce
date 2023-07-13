import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_login/screen_login.dart';
import 'package:hrx_store/presentation/page_login/widgets/widget.dart';

import '../../core/constant.dart';
import '../../services/firebase_auth/fire_base_auth.dart';
import '../comman_widgets/common_widgets.dart';

class ScreenForgotPassword extends StatelessWidget {
  ScreenForgotPassword({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final emailController = TextEditingController();
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
                BackNavigationButton(page: ScreenLogin()),
                kHeight30,
                kHeight30,
                const Text(
                  "Reset password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                kHeight30,
                kHeight30,
                TextFormFeildLogin(
                  controller: emailController,
                  title: 'Email Id',
                  emailValidation: true,
                ),
                kHeight30,
                kHeight30,
                InkWell(
                  onTap: () {
                    if (emailController.text.isEmpty) {
                      showSnackbar('All fields are required', context);
                    } else {
                      FirebaseAuthentication.resetPassword(
                        context: context,
                        formKey: _formKey,
                        emailController: emailController,
                      );
                    }
                  },
                  child: const ActionButtons(
                      colr: Colors.black,
                      string: 'Reset your password',
                      stringColor: Colors.white),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
