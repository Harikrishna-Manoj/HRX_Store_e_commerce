import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../core/Model/product.dart';
import '../../services/search_service/search_service.dart';
import '../../services/wishlist_service/wishlist_service.dart';
import '../page_product_detail/screem_product_detail.dart';

class AllGridProducts extends StatelessWidget {
  const AllGridProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return StreamBuilder(
        stream: SeacrchService.getProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went worng'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!;
          List<Product> productList =
              SeacrchService.convertToProductsList(documents);

          return GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              clipBehavior: Clip.none,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              childAspectRatio: 1 / 1.45,
              children: List.generate(
                  productList.length,
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
                                            id: productList[index].id!),
                                        type: PageTransitionType.fade));
                              },
                              child: Card(
                                elevation: 3,
                                child: SizedBox(
                                  width: size.width * 0.6,
                                  height: size.height * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(children: [
                                        Container(
                                          width: size.width * 0.45,
                                          height: size.width * 0.45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              productList[index].imageurl!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        FavouriteButton(
                                          id: productList[index].id!,
                                          amount: productList[index]
                                              .price!
                                              .toString(),
                                          name: productList[index].name,
                                          imageurl:
                                              productList[index].imageurl!,
                                          category:
                                              productList[index].category!,
                                        ),
                                      ]),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 5),
                                        child: TextScroll(
                                          productList[index].name,
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
                                          "Size : ${productList[index].size!}",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 5),
                                        child: Text(
                                          'Rate : ₹${productList[index].price}',
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
