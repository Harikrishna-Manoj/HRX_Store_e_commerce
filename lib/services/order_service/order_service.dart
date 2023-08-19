import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../address_service/address_service.dart';

class OrderService {
  static Future<QuerySnapshot> getProductIdFromOrdersActive() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userID)
        // .where('orderStatus', isEqualTo: 'Placed')
        .get();
    return querySnapshot;
  }

  static Future<QuerySnapshot> getProductIdFromOrdersCompleted() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: userID)
        .where('orderStatus', isEqualTo: 'delivered')
        .get();
    return querySnapshot;
  }

  static Future<QuerySnapshot> getProducts() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('product').get();
    return querySnapshot;
  }

  static deleteOrder(String orderId) async {
    final orderRef =
        FirebaseFirestore.instance.collection('orders').doc(orderId);
    await orderRef.delete();
    Fluttertoast.showToast(msg: 'Order cancelled');
  }

  static Future<DocumentSnapshot> getOrderedProduct(String orderId) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: AddressService.userID)
        .where('orderId', isEqualTo: orderId)
        .get();
    return snapShot.docs.first;
  }

  static orderStatusUpdate(String orderId, String status) async {
    final orderRef =
        FirebaseFirestore.instance.collection('orders').doc(orderId);
    await orderRef.update({'orderStatus': status});
  }

  static returnOrder(
      String reason, String orderId, String userId, String productId) async {
    final returnRef = FirebaseFirestore.instance.collection('return').doc();
    await returnRef.set({
      'returnId': returnRef.id,
      'orderId': orderId,
      'userId': userId,
      'reason': reason,
      'productId': productId
    });
    Fluttertoast.showToast(msg: 'Return request sended');
  }

  static Future<QuerySnapshot> getProductIdFromReturnList() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('return')
        .where('userId', isEqualTo: userID)
        .get();
    return querySnapshot;
  }
}
