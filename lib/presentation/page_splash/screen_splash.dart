import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrx_store/presentation/page_splash/pagedirection/page_direction.dart';
import 'package:page_transition/page_transition.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.leftToRight,
          child: const PageDirection(),
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.15),
              child: Image.asset(
                "asset/images/LOGO 2.png",
                scale: 2.5,
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  Text(
                    "HRX  STORE",
                    style: TextStyle(
                        fontFamily: GoogleFonts.michroma().fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        color: Colors.black),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText('Shoes • Cloths • Bags',
                            speed: const Duration(milliseconds: 100),
                            curve: Curves.decelerate,
                            cursor: ''),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
