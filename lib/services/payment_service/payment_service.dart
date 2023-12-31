import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrx_store/core/Model/order.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_order_successfull/screen_order_success.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  static final dateTime = DateTime.now();
  static final userId = FirebaseAuth.instance.currentUser!.email;
  static placeOrderCashOnDelivery(
      int? totalValue,
      String? addressId,
      List<dynamic>? productId,
      String? orderStatus,
      String? paymentMethod,
      BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );
    for (var product in productId!) {
      final orderRef = FirebaseFirestore.instance.collection('orders').doc();
      OrderModel orderDeatails = OrderModel(
          productId: product,
          totalValue: totalValue,
          addressId: addressId,
          userId: userId,
          orderDate: '${dateTime.day}/${dateTime.month}/${dateTime.year}',
          orderId: orderRef.id,
          orderStatus: orderStatus,
          paymentMethod: paymentMethod);
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart');
      await orderRef.set(orderDeatails.toJason());
      final cartProduct = await cartRef.doc(product).get();
      Map<String, dynamic> data = cartProduct.data() ?? {'productcount': 1};
      await orderRef.update({'count': data['productcount']});

      // ignore: prefer_if_null_operators
      if (cartProduct.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(product)
            .delete();
      }
    }

    // ignore: use_build_context_synchronously
    Navigator.pop(context); // ignore:
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        PageTransition(
            child: const ScreenOrderSuccess(orderId: 'id'),
            type: PageTransitionType.fade));
  }

  static placeOrderRazorPay(
      int? totalValue,
      String? addressId,
      List<dynamic>? productId,
      String? orderStatus,
      String? paymentMethod,
      BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );

    var options = {
      'key': razorPayKey,
      'amount': totalValue! * 100,
      'name': 'HRX Store',
      'description': productId,
      'prefill': {'contact': '', 'email': userId}
    };
    Razorpay razorpay = Razorpay();

    // ignore: no_leading_underscores_for_local_identifiers
    _handlePaymentSuccess(PaymentSuccessResponse response, BuildContext context,
        List<dynamic>? productId) async {
      for (var product in productId!) {
        final orderRef = FirebaseFirestore.instance.collection('orders').doc();
        OrderModel orderDeatails = OrderModel(
            productId: product,
            totalValue: totalValue,
            addressId: addressId,
            userId: userId,
            orderDate: '${dateTime.day}/${dateTime.month}/${dateTime.year}',
            orderId: orderRef.id,
            orderStatus: orderStatus,
            paymentMethod: paymentMethod);
        final cartRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart');
        await orderRef.set(orderDeatails.toJason());
        final cartProduct = await cartRef.doc(product).get();
        Map<String, dynamic> data = cartProduct.data() ?? {'productcount': 1};
        await orderRef.update({'count': data['productcount']});

        // ignore: prefer_if_null_operators
        if (cartProduct.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('cart')
              .doc(product)
              .delete();
        }
      }

      Fluttertoast.showToast(msg: 'Payment Success');
      // ignore: use_build_context_synchronously
      Navigator.pop(context); // ignore:
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          PageTransition(
              child: const ScreenOrderSuccess(orderId: "id"),
              type: PageTransitionType.fade));
      log('order placed');
    }

    // ignore: no_leading_underscores_for_local_identifiers
    _handlePaymentError(PaymentFailureResponse response, BuildContext context) {
      Fluttertoast.showToast(msg: 'Payment Unsuccess');
    }

    razorpay.open(options);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      _handlePaymentSuccess(response, context, productId);
    });
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      _handlePaymentError(response, context);
    });
  }
}
