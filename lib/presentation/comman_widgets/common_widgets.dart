import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_main/screen_navigationbar.dart';
import 'package:page_transition/page_transition.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons(
      {super.key,
      required this.colr,
      required this.string,
      required this.stringColor});

  final Color colr;
  final String string;
  final Color stringColor;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        color: colr,
      ),
      height: size.width * .16,
      width: size.height * .43,
      child: Center(
          child: Text(
        string,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: stringColor),
      )),
    );
  }
}

class SuccessNotification extends StatelessWidget {
  const SuccessNotification({
    super.key,
    required this.colr,
    required this.string,
    required this.stringColor,
    this.message,
    required this.buttonColor,
    required this.buttonText,
    required this.buttonTextColour,
  });
  final String? message;
  final Color colr;
  final String string;
  final Color stringColor;
  final Color buttonColor;
  final String buttonText;
  final Color buttonTextColour;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: size.height * 0.30,
        width: size.height * 0.15,
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 50,
              color: Colors.green[300],
            ),
            kHeight15,
            const Text(
              "Successful!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              message!,
              textAlign: TextAlign.center,
            ),
            kHeight30,
            InkWell(
              onTap: () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                      child: ScreenNavigationbar(),
                      type: PageTransitionType.rightToLeft)),
              child: SmallActionButtons(
                  colr: buttonColor,
                  string: buttonText,
                  stringColor: buttonTextColour),
            )
          ],
        ),
      ),
    );
  }
}

class SmallActionButtons extends StatelessWidget {
  const SmallActionButtons(
      {super.key,
      required this.colr,
      required this.string,
      required this.stringColor});

  final Color colr;
  final String string;
  final Color stringColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        color: colr,
      ),
      height: 50,
      width: 180,
      child: Center(
          child: Text(
        string,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: stringColor),
      )),
    );
  }
}

showSnackbar(String? text, BuildContext context) {
  if (text == null) return;
  final snackBar = SnackBar(
    content: Text(text),
    backgroundColor: Colors.black,
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
