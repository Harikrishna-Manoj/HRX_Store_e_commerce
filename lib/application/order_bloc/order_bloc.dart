import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrx_store/core/Model/order.dart';
import 'package:hrx_store/core/Model/product.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderInitial()) {
    on<GetAllOrders>((event, emit) async {
      emit(const OrderState(
          orderList: [], orderProductList: [], isLoading: true));
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final userID = user!.email;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userID)
          .get();
      final orderList = querySnapshot.docs
          .map(
            (doc) => OrderModel.fromJason(doc.data()),
          )
          .toList();
      final productSnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      List<Product> orderProductList = [];
      for (var i = 0; i < orderList.length; i++) {
        orderProductList = productSnapshot.docs
            .map(
              (doc) => Product.fromJson(doc.data()),
            )
            .where((product) => orderList[i].productId!.contains(product.id))
            .toList();
      }
      emit(OrderState(
          orderList: orderList,
          orderProductList: orderProductList,
          isLoading: false));
    });
    on<ReturnOrder>((event, emit) async {
      final returnRef = FirebaseFirestore.instance.collection('return').doc();
      await returnRef.set({
        'returnId': returnRef.id,
        'orderId': event.orderId,
        'userId': event.userId,
        'reason': event.reason,
        'productId': event.productId
      });
      final orderRef =
          FirebaseFirestore.instance.collection('orders').doc(event.orderId);
      await orderRef.update({'orderStatus': 'requested'});
      Fluttertoast.showToast(msg: 'Return request sended');
      add(GetAllOrders());
    });
    on<CancelOrder>((event, emit) async {
      final orderRef =
          FirebaseFirestore.instance.collection('orders').doc(event.orderId);
      await orderRef.delete();
      Fluttertoast.showToast(msg: 'Order cancelled');
      add(GetAllOrders());
    });
  }
}
