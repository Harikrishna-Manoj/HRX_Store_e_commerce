import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_payment/widget.dart';
import 'package:hrx_store/services/payment_service/payment_service.dart';

import '../../core/constant.dart';

// ignore: must_be_immutable
class ScreenPayment extends StatelessWidget {
  ScreenPayment(
      {super.key,
      this.productId,
      required this.toalValue,
      required this.addressId,
      this.productIdList,
      required this.fromCart});
  String? productId;
  final String toalValue;
  final String addressId;
  List<dynamic>? productIdList;
  final bool fromCart;
  @override
  Widget build(BuildContext context) {
    List<dynamic> productIds = [];
    if (fromCart == true) {
      for (var i = 0; i < productIdList!.length; i++) {
        productIds.add(productIdList![i]);
      }
    }
    fromCart ? productIds : productIds.add(productId!);
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
                InkWell(
                  onTap: () => RazorPayConfirmation(context, size, productIds),
                  child: const PaymentCard(
                      value: 'Razor Pay',
                      imageUrl: 'asset/images/razorpay.png'),
                ),
                kHeight20,
                InkWell(
                  onTap: () {
                    CODConfirmation(context, size, productIds);
                  },
                  child: const PaymentCard(
                      value: 'Cash On Delivery',
                      imageUrl: 'asset/images/cash_on_delivery.png'),
                ),
                kHeight20,
                // const PaymentCard(
                //   value: 'card',
                //   imageUrl: 'asset/images/card.png',
                // ),
                // kHeight20,
                // const AddCard(colr: Colors.white, value: 'Add card'),
              ],
            ),
          ),
        ),
      )),
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> RazorPayConfirmation(
      BuildContext context, Size size, List<dynamic> productIds) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_outlined))
            ]),
            const Text(
              'Continue with Razorpay',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SizedBox(
          height: size.height * .3,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green[100],
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green[200],
                    child: Icon(
                      Icons.money,
                      color: Colors.green[400],
                      size: 60,
                    )),
              ),
              kHeight30,
              kHeight30,
              FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {
                  PaymentService.placeOrderRazorPay(int.parse(toalValue),
                      addressId, productIds, 'placed', 'Razorpay', context);
                },
                label: const Text('Place order',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> CODConfirmation(
      BuildContext context, Size size, List<dynamic> productIds) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel_outlined))
            ]),
            const Text(
              'Continue with COD',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SizedBox(
          height: size.height * .3,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green[100],
                child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green[200],
                    child: Icon(
                      Icons.money,
                      color: Colors.green[400],
                      size: 60,
                    )),
              ),
              kHeight30,
              kHeight30,
              FloatingActionButton.extended(
                backgroundColor: Colors.black,
                onPressed: () {
                  PaymentService.placeOrderCashOnDelivery(int.parse(toalValue),
                      addressId, productIds, 'placed', 'cod', context);
                },
                label: const Text('Place order',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
