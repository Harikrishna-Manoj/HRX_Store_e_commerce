import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/cart_bloc/cart_bloc_bloc.dart';
import 'package:hrx_store/presentation/page_product_detail/screem_product_detail.dart';
import 'package:hrx_store/services/address_service/address_service.dart';
import 'package:hrx_store/services/cart_service/cart_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../core/constant.dart';
import '../../../page_delivery/screen_delivery.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Container(
          width: size.width,
          height: size.height * 0.13,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 4, right: 15),
                height: size.height * 0.12,
                width: size.width * .23,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(13)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Roller Rabit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text('Roller Rabit'),
                  kHeight20,
                  const Text(
                    '300',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          )),
    );
  }
}

class TotalAmountWidget extends StatelessWidget {
  const TotalAmountWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AddressService.userID)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          int totalPrice = 0;
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return TotalPriceShimmer(size: size);
          }
          if (snapshot.hasData) {
            List<dynamic> productPrice = snapshot.data!.docs
                .map((doc) => doc.get('totalprice'))
                .toList();
            totalPrice = CartServices.updateTotalPrice(productPrice);
          }

          return Visibility(
            visible: totalPrice != 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total (${snapshot.data!.docs.length} items):',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text('Rs.$totalPrice',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        });
  }
}

class TotalPriceShimmer extends StatelessWidget {
  const TotalPriceShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        color: Colors.black,
        child: SizedBox(
          width: size.width,
          height: 25,
        ));
  }
}

// ignore: must_be_immutable
class SlideAction extends StatelessWidget {
  SlideAction(
      {super.key,
      required this.name,
      required this.productSize,
      required this.price,
      required this.image,
      required this.id,
      required this.index,
      this.cartPageRebuildNotifer});
  final String name;
  final String productSize;
  final String price;
  final String image;
  final String id;
  final String index;
  ValueNotifier<bool>? cartPageRebuildNotifer;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Dismissible(
      key: Key(index),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          bool dismiss = false;
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Are you sure?",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  actions: [
                    TextButton(
                        onPressed: () {
                          dismiss = false;
                          Navigator.pop(context);
                        },
                        child: const Text("No",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<CartBlocBloc>(context)
                              .add(DeleteFromCart(productId: id));
                          dismiss = true;
                          Navigator.pop(context);
                          CartServices.checkingTheProductInCart(
                              id, cartPageRebuildNotifer!);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        )),
                  ],
                );
              });
          return dismiss;
        }
        return null;
      },
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            PageTransition(
                child: ScreenProductDetails(id: id),
                type: PageTransitionType.fade)),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Container(
              width: size.width,
              height: size.height * 0.18,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4, right: 15),
                    height: size.height * 0.17,
                    width: size.width * .26,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(13)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight30,
                      TextScroll(
                        name,
                        mode: TextScrollMode.endless,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(30, 0)),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text('Size: $productSize'),
                      kHeight10,
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(AddressService.userID)
                              .collection('cart')
                              .doc(id)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            // print('rebuilded');
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return const SizedBox
                                  .shrink(); // Handle case where document doesn't exist anymore
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: size.width * 0.135,
                                width: size.width * 0.05,
                              );
                            }
                            return Row(
                              children: [
                                Text(
                                  "₹ $price X ${snapshot.data['productcount']}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 40,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            onPressed: () {
                                              if (snapshot
                                                      .data['productcount'] !=
                                                  1) {
                                                BlocProvider.of<CartBlocBloc>(
                                                        context)
                                                    .add(
                                                        IncreaseOrDereaseQuantity(
                                                            productId: id,
                                                            increase: false,
                                                            price: int.parse(
                                                                price)));
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Text(
                                                        'Atleast 1 product needed. Do you want remove ?',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'No',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            BlocProvider.of<
                                                                        CartBlocBloc>(
                                                                    context)
                                                                .add(DeleteFromCart(
                                                                    productId:
                                                                        id));

                                                            CartServices
                                                                .checkingTheProductInCart(
                                                                    id,
                                                                    cartPageRebuildNotifer!);
                                                          },
                                                          child: const Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)))
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.minimize,
                                            )),
                                        TextScroll(
                                          '${snapshot.data['productcount']}',
                                          mode: TextScrollMode.endless,
                                          velocity: const Velocity(
                                              pixelsPerSecond: Offset(30, 0)),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              BlocProvider.of<CartBlocBloc>(
                                                      context)
                                                  .add(
                                                      IncreaseOrDereaseQuantity(
                                                          productId: id,
                                                          increase: true,
                                                          price: int.parse(
                                                              price)));
                                            },
                                            icon: const Icon(Icons.add)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class CartShimmer extends StatelessWidget {
  const CartShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Shimmer(
        color: Colors.black,
        child: Container(
            width: size.width,
            height: size.height * 0.18,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
                  child: Shimmer(
                    color: Colors.black,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight30,
                    Shimmer(
                      color: Colors.black,
                      child: SizedBox(
                        width: size.width * 0.3,
                        child: const Padding(
                            padding: EdgeInsets.only(left: 8.0, top: 5),
                            child: SizedBox(
                              height: 5,
                              width: 80,
                            )),
                      ),
                    ),
                    kHeight10,
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 5,
                            width: 80,
                          )),
                    ),
                    kHeight20,
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 20,
                            width: 80,
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class CartProceedButton extends StatelessWidget {
  const CartProceedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AddressService.userID)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something went wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer(
                color: Colors.black,
                child: SizedBox(
                  width: size.width * 0.9,
                  height: 30,
                ));
          }
          return snapshot.data!.docs.isNotEmpty
              ? FloatingActionButton.extended(
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
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                )
              : const SizedBox();
        });
  }
}
