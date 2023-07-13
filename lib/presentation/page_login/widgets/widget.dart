import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_login/screen_forget_password.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/constant.dart';
import '../../../services/firebase_auth/fire_base_auth.dart';
import '../../page_signin/screen_signin.dart';

class BackNavigationButton extends StatelessWidget {
  const BackNavigationButton({
    super.key,
    required this.page,
  });
  final Widget page;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            PageTransition(child: page, type: PageTransitionType.leftToRight));
      },
      icon: Icon(
        Icons.arrow_circle_left_rounded,
        size: largeFont,
        color: Colors.black,
      ),
    );
  }
}

// ignore: must_be_immutable
class TextFormFeildLogin extends StatefulWidget {
  TextFormFeildLogin(
      {super.key,
      required this.controller,
      this.trailIcon1,
      this.trailIcon2,
      this.hiniText,
      this.passwordVisibility = false,
      required this.title,
      this.isPasswordLength = false,
      this.emailValidation = false});
  final TextEditingController controller;
  final IconData? trailIcon1;
  final IconData? trailIcon2;
  bool passwordVisibility = false;
  final String? hiniText;
  final String title;
  bool emailValidation;
  bool isPasswordLength;
  @override
  State<TextFormFeildLogin> createState() => _TextFormFeildLoginState();
}

class _TextFormFeildLoginState extends State<TextFormFeildLogin> {
  late ValueNotifier<bool> visibilityNotifier =
      ValueNotifier(widget.passwordVisibility);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
            valueListenable: visibilityNotifier,
            builder: (context, visible, child) {
              return TextFormField(
                  obscureText: visible,
                  cursorColor: Colors.black,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    } else if (widget.emailValidation) {
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return "Enter Valid Email";
                      }
                    } else if (widget.isPasswordLength) {
                      if (value.length < 6) {
                        return 'Password must contains more than 6 letters';
                      }
                    }
                    return null;
                  },
                  controller: widget.controller,
                  decoration: InputDecoration(
                      labelText: widget.title,
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: const EdgeInsets.all(0),
                      hintText: widget.hiniText,
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: widget.trailIcon1 != null
                          ? ValueListenableBuilder(
                              valueListenable: visibilityNotifier,
                              builder: (context, visibility, _) {
                                return IconButton(
                                    onPressed: () {
                                      visibilityNotifier.value =
                                          !visibilityNotifier.value;
                                    },
                                    icon: visibility
                                        ? Icon(
                                            widget.trailIcon1,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            widget.trailIcon2,
                                            color: Colors.grey,
                                          ));
                              })
                          : null));
            }),
      ],
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FirebaseAuthentication.signInwithGoogle(context: context);
      },
      child: Center(
        child: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.white,
          child: Image.asset('asset/images/Google.png'),
        ),
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: ScreenForgotPassword(),
                  type: PageTransitionType.rightToLeft));
        },
        child: const Text(
          'Forgot password',
          style: TextStyle(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

class NoAccount extends StatelessWidget {
  const NoAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No account?'),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: ScreenSignin(),
                    type: PageTransitionType.rightToLeft));
          },
          child: const Text(
            ' Create',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
