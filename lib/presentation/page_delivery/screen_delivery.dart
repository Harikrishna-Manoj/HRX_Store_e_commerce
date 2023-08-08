import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_delivery/widgets.dart';

import '../../core/constant.dart';

// ignore: must_be_immutable
class ScreenDelivery extends StatelessWidget {
  ScreenDelivery({super.key, required this.fromCart, this.id});
  final bool fromCart;
  String? id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Delivery address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left,
              size: 35,
            )),
      ),
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
                const SubTitles(
                    heading: 'Shipping address',
                    editIcon: Icons.edit_note_outlined),
                kHeight20,
                const AddressCard(),
                kHeight10,
                const SubTitles(heading: 'Product Item'),
                kHeight10,
                fromCart == true
                    ? const FromCartPageProductCard()
                    : FromProductPageProductCard(id: id!),
                const SubTitles(heading: 'Total amount'),
                fromCart == true
                    ? const FromCartPageTotalAmount()
                    : FromProductPageTotalAmount(
                        id: id!,
                      ),
                SizedBox(
                  width: size.width,
                  height: size.height * .2,
                )
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
              label: Row(
                children: [
                  const ProductPriceText(
                    textColor: Colors.grey,
                    text: 'Total Price : ',
                    boldness: FontWeight.bold,
                    textSize: 14,
                  ),
                  fromCart
                      ? const FromCartTotalAmountFloating()
                      : FromProductTotalAmountFloating(id: id)
                ],
              )),
          const SizedBox(
            width: 5,
          ),
          fromCart
              ? const FromCartProceedButton()
              : FromProductPageProceedButton(
                  id: id!,
                )
        ],
      ),
    );
  }
}
