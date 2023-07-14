import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_delivery/widgets.dart';
import 'package:hrx_store/presentation/page_payment/screen_payment.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/constant.dart';

class ScreenDelivery extends StatelessWidget {
  const ScreenDelivery({super.key});

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
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        size: largeFont,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text('Delivery address',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
                kHeight30,
                const SubTitles(
                    heading: 'Shipping address',
                    editIcon: Icons.edit_note_outlined),
                const AddressDetails(),
                const SubTitles(heading: 'Product Item'),
                const ProductCard(),
              ],
            ),
          ),
        ),
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
              backgroundColor: Colors.white,
              elevation: 0,
              highlightElevation: 0,
              onPressed: () {},
              label: const Row(
                children: [
                  ProductPriceText(
                    textColor: Colors.grey,
                    text: 'Total Price : ',
                    boldness: FontWeight.bold,
                    textSize: 14,
                  ),
                  ProductPriceText(
                    textColor: Colors.black,
                    text: '${199}',
                    boldness: FontWeight.bold,
                    textSize: 20,
                  )
                ],
              )),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const ScreenPayment(),
                        type: PageTransitionType.rightToLeft));
              },
              backgroundColor: Colors.black,
              label: const ProductPriceText(
                textColor: Colors.white,
                text: 'Place Order',
                boldness: FontWeight.bold,
                textSize: 20,
              ))
        ],
      ),
    );
  }
}
