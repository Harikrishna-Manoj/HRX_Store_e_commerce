import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/comman_widgets/common_widgets.dart';

class CartServices {
  static Future addToCart(
      {required String productId,
      required String colour,
      required String size,
      required int totalValue,
      required BuildContext context}) async {
    try {
      FirebaseAuth userInstance = FirebaseAuth.instance;
      User? currentUser = userInstance.currentUser;
      final userId = currentUser!.email;
      final cartReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId);
      await cartReference.set({
        'productid': productId,
        'productsize': size,
        'productcolor': colour,
        'totalprice': totalValue
      });
      // ignore: use_build_context_synchronously
      showSnackbar('Added to cart', context);
    } catch (e) {
      // print(e.toString());
      showSnackbar(e.toString(), context);
    }
  }

  static Future reomveFromCart(
      {required String productId, required BuildContext context}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userId = currentUser!.email;
      final cartCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(productId);
      await cartCollection.delete();
      // ignore: use_build_context_synchronously
      showSnackbar('Removed from cart', context);
    } catch (e) {
      // print(e.toString());
      showSnackbar(e.toString(), context);
    }
  }

  static Future<bool> checkProductExistance(
      {required String productId,
      required String colour,
      required String size,
      required int totalValue,
      required BuildContext context}) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('product').doc(productId);
    final DocumentSnapshot documentSnapshot = await docRef.get();
    if (documentSnapshot.exists) {
      final dynamic productColor = documentSnapshot['color'];
      final dynamic productSize = documentSnapshot['size'];
      if (productColor == colour && productSize == size) {
        return true;
      }
    } else {
      return false;
    }
    // ignore: use_build_context_synchronously
    showSnackbar('Selected combination is not available', context);
    return false;
  }
}
