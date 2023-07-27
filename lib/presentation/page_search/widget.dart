import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/wishlist_service/wishlist_service.dart';

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
