import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_payment/widget.dart';

import '../../core/constant.dart';

class ScreenPayment extends StatelessWidget {
  const ScreenPayment({super.key});

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
                    const Text('Payment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ],
                ),
                kHeight30,
                const PaymentCard(colr: Colors.black, value: 'card'),
                kHeight20,
                const PaymentCard(colr: Colors.red, value: 'Razo'),
                kHeight20,
                const PaymentCard(colr: Colors.blue, value: 'Cash On Delivery'),
                kHeight20,
                const AddCard(colr: Colors.white, value: 'Add card'),
              ],
            ),
          ),
        ),
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {},
          label: const FloatingText(
            textColor: Colors.white,
            text: 'Proceed',
            boldness: FontWeight.bold,
            textSize: 18,
          )),
    );
  }
}
