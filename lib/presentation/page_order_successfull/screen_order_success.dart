import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_main/screen_navigationbar.dart';
import 'package:page_transition/page_transition.dart';

class ScreenOrderSuccess extends StatelessWidget {
  const ScreenOrderSuccess({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              kHeight30,
              kHeight20,
              Image.asset(
                'asset/images/order_success.png',
                scale: 4,
              ),
              kHeight30,
              const Text(
                'Hooray! Your order was confirmed',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              kHeight30,
              kHeight20,
              Text(
                'Order ID : $orderId',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              kHeight30,
              FloatingActionButton.extended(
                  elevation: 2,
                  backgroundColor: Colors.white,
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      PageTransition(
                          child: ScreenNavigationbar(),
                          type: PageTransitionType.fade),
                      (Route route) => false),
                  label: const Text(
                    'Continue shopping',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
