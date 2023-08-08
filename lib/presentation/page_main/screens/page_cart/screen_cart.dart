import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_delivery/screen_delivery.dart';
import 'package:hrx_store/presentation/page_main/screens/page_cart/widgets.dart';
import 'package:hrx_store/services/cart_service/cart_service.dart';
import 'package:page_transition/page_transition.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> cartPageRebuildNotifer = ValueNotifier(true);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        key: scaffoldKey,
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
                    child: ValueListenableBuilder(
                        valueListenable: cartPageRebuildNotifer,
                        builder: (context, value, child) {
                          cartPageRebuildNotifer.value = true;
                          return FutureBuilder<QuerySnapshot>(
                              future: CartServices.getProductId(),
                              builder: (context, cartSnapshot) {
                                if (cartSnapshot.hasData) {
                                  List<dynamic> productId = cartSnapshot
                                      .data!.docs
                                      .map((doc) => doc.get('productid'))
                                      .toList();
                                  // print(cartSnapshot.data);
                                  // print(productId);
                                  return FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('product')
                                          .get(),
                                      builder: (context, productSnapshot) {
                                        // print(productSnapshot.data);
                                        if (productSnapshot.hasData) {
                                          List<Product> productList =
                                              productSnapshot.data!.docs
                                                  .map((doc) =>
                                                      Product.fromJson(
                                                          doc.data() as Map<
                                                              String, dynamic>))
                                                  .where((product) => productId
                                                      .contains(product.id))
                                                  .toList();
                                          // print(productList);
                                          return productList.isNotEmpty
                                              ? ListView.separated(
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SlideAction(
                                                        cartPageRebuildNotifer:
                                                            cartPageRebuildNotifer,
                                                        index: index.toString(),
                                                        id: productList[index]
                                                            .id!,
                                                        name: productList[index]
                                                            .name,
                                                        productSize:
                                                            productList[index]
                                                                .size!,
                                                        price:
                                                            productList[index]
                                                                .price
                                                                .toString(),
                                                        image:
                                                            productList[index]
                                                                .imageurl!);
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          kHeight10,
                                                  itemCount: productList.length)
                                              : const Center(
                                                  child: Text('Cart is empty'),
                                                );
                                        }
                                        return CartShimmer(size: size);
                                      });
                                }
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 2,
                                  ),
                                );
                              });
                        }),
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
                  child: ScreenDelivery(fromCart: true),
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
