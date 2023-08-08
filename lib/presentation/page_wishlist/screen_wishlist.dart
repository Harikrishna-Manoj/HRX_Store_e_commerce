import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:hrx_store/presentation/page_wishlist/widgets.dart';
import 'package:hrx_store/services/wishlist_service/wishlist_service.dart';

import '../../core/constant.dart';

class ScreenWishlist extends StatelessWidget {
  const ScreenWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> pageRefreashNotifier = ValueNotifier<bool>(false);
    FirebaseAuth userInstance = FirebaseAuth.instance;
    User? currentUser = userInstance.currentUser;
    final userId = currentUser!.email;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Wishlist ♥',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.89,
                width: size.width,
                child: StreamBuilder(
                  stream: WishlistService.wishlistgetProducts(userId!),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return WishListShimmer(size: size);
                    }
                    List<DocumentSnapshot> documents = snapshot.data!;
                    List<WishlistProduct> wishlistProducts =
                        WishlistService.convertToProductsList(documents);
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: ValueListenableBuilder(
                          valueListenable: pageRefreashNotifier,
                          builder: (context, value, child) {
                            return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  // print(wishlistProducts[index].id);
                                  if (wishlistProducts.isEmpty) {
                                    return const Center(
                                      child: Text('No wished items'),
                                    );
                                  }
                                  return WishlistProductCard(
                                    pageRefreashNotifier: pageRefreashNotifier,
                                    category: wishlistProducts[index].category!,
                                    id: wishlistProducts[index].id!,
                                    imageUrl: wishlistProducts[index].imageurl!,
                                    name: wishlistProducts[index].name,
                                    price: wishlistProducts[index].price!,
                                  );
                                },
                                separatorBuilder: (context, index) => kHeight10,
                                itemCount: wishlistProducts.length);
                          }),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
