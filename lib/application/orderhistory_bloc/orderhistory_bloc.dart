import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../core/Model/order.dart';
import '../../core/Model/product.dart';

part 'orderhistory_event.dart';
part 'orderhistory_state.dart';

class OrderhistoryBloc extends Bloc<OrderhistoryEvent, OrderhistoryState> {
  OrderhistoryBloc() : super(const OrderhistoryInitial()) {
    on<GetAllOrderHistory>((event, emit) async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final userID = user!.email;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: userID)
          .where('orderStatus', isEqualTo: 'delivered')
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
      emit(OrderhistoryState(
          orderList: orderList, orderProductList: orderProductList));
    });
  }
}
