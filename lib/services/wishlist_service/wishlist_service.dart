import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../core/Model/product.dart';

class WishlistService {
  static Future addToWishlist(
      {required String productId,
      required String image,
      required String productName,
      required String category,
      required String amount,
      required BuildContext context}) async {
    try {
      FirebaseAuth userInstance = FirebaseAuth.instance;
      User? currentUser = userInstance.currentUser;
      final userId = currentUser!.email;
      final whishListReference = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(productId);
      await whishListReference.set({
        'id': productId,
        'name': productName,
        'price': amount,
        'category': category,
        'imageurl': image,
      });
      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: 'Added to wishlist');
    } catch (e) {
      // print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static Future reomveFromWishlist(
      {required String productId, required BuildContext context}) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      final userId = currentUser!.email;
      final cartCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(productId);
      await cartCollection.delete();
      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: 'Removed from wishlist');
    } catch (e) {
      // print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static Stream wishlistgetProducts(String user) async* {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .collection('wishlist')
        .get();
    final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
    // print(docs.toString());
    yield docs;
  }

  static List<WishlistProduct> convertToProductsList(
      List<DocumentSnapshot> documents) {
    // print(documents.map((snapshot) {
    //   return WishlistProduct.fromJson(snapshot.data() as Map<String, dynamic>);
    // }).toList());
    return documents.map((snapshot) {
      return WishlistProduct.fromJson(snapshot.data() as Map<String, dynamic>);
    }).toList();
  }
}
