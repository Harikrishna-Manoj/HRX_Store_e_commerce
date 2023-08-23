import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/viewall_bloc/viewall_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../core/constant.dart';
import '../../services/wishlist_service/wishlist_service.dart';
import '../page_product_detail/screem_product_detail.dart';

class AllGridProducts extends StatelessWidget {
  const AllGridProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ViewallBloc>(context).add(GetAllProducts());
    });
    Size size = MediaQuery.sizeOf(context);

    return BlocBuilder<ViewallBloc, ViewallState>(builder: (context, state) {
      return GridView.count(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          clipBehavior: Clip.none,
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          childAspectRatio: 1 / 1.45,
          children: List.generate(
              state.productList.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            // print(searchList[index].id);
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ScreenProductDetails(
                                        id: state.productList[index].id!),
                                    type: PageTransitionType.fade));
                          },
                          child: Card(
                            elevation: 3,
                            child: SizedBox(
                              width: size.width * 0.6,
                              height: size.height * 0.6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(children: [
                                    Container(
                                      width: size.width * 0.45,
                                      height: size.width * 0.45,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          state.productList[index].imageurl!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    FavouriteButton(
                                      id: state.productList[index].id!,
                                      amount: state.productList[index].price!
                                          .toString(),
                                      name: state.productList[index].name,
                                      imageurl:
                                          state.productList[index].imageurl!,
                                      category:
                                          state.productList[index].category!,
                                    ),
                                  ]),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 5),
                                    child: TextScroll(
                                      state.productList[index].name,
                                      mode: TextScrollMode.endless,
                                      velocity: const Velocity(
                                          pixelsPerSecond: Offset(30, 0)),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 5),
                                    child: Text(
                                      "Size : ${state.productList[index].size!}",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 5),
                                    child: Text(
                                      'Rate : ₹${state.productList[index].price}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )));
    });
  }
}

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    super.key,
    required this.id,
    required this.imageurl,
    required this.amount,
    required this.name,
    required this.category,
  });

  final String id;
  final String imageurl;
  final String amount;
  final String name;
  final String category;
  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  ValueNotifier<bool> wishlistIconChangeNotifer = ValueNotifier<bool>(false);
  checkingWishlistStatus(String productId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser!.email;
    final wishlistSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(productId)
        .get();

    if (wishlistSnapshot.exists) {
      wishlistIconChangeNotifer.value = true;
    } else {
      wishlistIconChangeNotifer.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkingWishlistStatus(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: wishlistIconChangeNotifer,
        builder: (context, value, child) {
          return Positioned(
            left: 110,
            child: IconButton(
                onPressed: () {
                  checkingWishlistStatus(widget.id);
                  if (wishlistIconChangeNotifer.value == false) {
                    WishlistService.addToWishlist(
                        amount: widget.amount,
                        productId: widget.id,
                        category: widget.category,
                        image: widget.imageurl,
                        productName: widget.name,
                        context: context);
                  } else {
                    WishlistService.reomveFromWishlist(
                        productId: widget.id, context: context);
                  }
                },
                icon: wishlistIconChangeNotifer.value == true
                    ? const Icon(
                        Icons.favorite_outlined,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      )),
          );
        });
  }
}

class GridShimmer extends StatelessWidget {
  const GridShimmer({
    super.key,
    required this.size,
    required this.length,
  });

  final Size size;
  final int length;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        clipBehavior: Clip.none,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        childAspectRatio: 1 / 1.45,
        children: List.generate(
            length,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Stack(
                    children: [
                      Card(
                        elevation: 3,
                        child: SizedBox(
                          width: size.width * 0.6,
                          height: size.height * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                Shimmer(
                                  color: Colors.black,
                                  child: Container(
                                    width: size.width * 0.45,
                                    height: size.width * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ]),
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
                              kHeight10,
                              Shimmer(
                                color: Colors.black,
                                child: const SizedBox(
                                  height: 10,
                                  width: 60,
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
