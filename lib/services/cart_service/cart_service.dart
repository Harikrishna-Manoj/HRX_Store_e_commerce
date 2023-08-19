import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartServices {
  static Future addToCart(
      {required String productId,
      required String colour,
      required String size,
      required int totalValue,
      required BuildContext context}) async {
    try {
      int productCount = 1;
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
        'productcount': productCount,
        'productcolor': colour,
        'totalprice': totalValue
      });
      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: 'Added to cart');
    } catch (e) {
      // print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
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
      Fluttertoast.showToast(msg: 'Removed from cart');
    } catch (e) {
      // print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static Future<bool> checkProductExistance(
      {required String productId,
      required String colour,
      required String size,
      // required int totalValue,
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
    Fluttertoast.showToast(msg: 'Selected combination is not available');

    return false;
  }

  static Future<QuerySnapshot> getProductId() async {
    final userId = FirebaseAuth.instance.currentUser!.email;
    final querySnapShot = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();
    return querySnapShot;
  }

  static addOrRemoveProductQuaantity(
      String id, bool increment, int price, BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.email;
    final cartReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(id);
    final DocumentSnapshot docSnapshot = await cartReference.get();
    final productCount = docSnapshot['productcount'];
    if (increment == true) {
      cartReference.update({
        'productcount': productCount + 1,
        'totalprice': docSnapshot['totalprice'] + price
      });
    } else {
      if (productCount > 1) {
        cartReference.update({
          'productcount': productCount - 1,
          'totalprice': docSnapshot['totalprice'] - price
        });
      }
    }
  }

  static int updateTotalPrice(List<dynamic> productPrices) {
    int totalValue = 0;
    for (var i = 0; i < productPrices.length; i++) {
      totalValue += productPrices[i] as int;
    }
    return totalValue;
  }

  static checkingTheProductInCart(
      String productId, ValueNotifier<bool> cartPageRebuildNotifer) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser!.email;
    final cartSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .get();

    if (cartSnapshot.exists) {
      cartPageRebuildNotifer.value = true;
    } else {
      cartPageRebuildNotifer.value = false;
    }
  }

  static Future<bool> checkingCartIsEmpty() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser!.email;
    final cartSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();
    // print(cartSnapshot.docs.length);
    if (cartSnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
