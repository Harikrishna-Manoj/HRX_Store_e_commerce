import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_delivery/screen_delivery.dart';
import 'package:hrx_store/presentation/page_main/screens/page_cart/widgets.dart';
import 'package:page_transition/page_transition.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Column(
                children: [
                  kHeight10,
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'My Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.6,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return const SlideAction();
                        },
                        separatorBuilder: (context, index) => kHeight10,
                        itemCount: 4),
                  ),
                  kHeight30,
                  const TotalAmountWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(
          Icons.arrow_circle_right_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const ScreenDelivery(),
                  type: PageTransitionType.rightToLeftWithFade));
        },
        label: const Text(
          'Proceed to Checkout',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
