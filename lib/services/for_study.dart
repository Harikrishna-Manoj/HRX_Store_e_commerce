import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ForStudy {
  payOnline(String prodcuctId) async {
    Razorpay razorPay = Razorpay();
    var options = {
      'key': razorPayKey,
      'amount': 100,
      'name': 'HRX Store',
      'prefill': {'email': 'email'}
    };
    handleSuccessPayment(PaymentSuccessResponse response) async {
      final orderRef = FirebaseFirestore.instance.collection('orders').doc();
      await orderRef.set({'id': orderRef.id, 'prodcuctId': prodcuctId});
    }

    handleFaliurePayment(PaymentFailureResponse response) {
      print('faliure payment');
    }

    razorPay.open(options);
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      handleSuccessPayment(response);
    });
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      handleFaliurePayment(response);
    });
  }
}
