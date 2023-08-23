import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:hrx_store/core/Model/return.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'returns_event.dart';
part 'returns_state.dart';

class ReturnsBloc extends Bloc<ReturnsEvent, ReturnsState> {
  ReturnsBloc() : super(const ReturnsInitial()) {
    on<GetAllReturnedProduct>((event, emit) async {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final userID = user!.email;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('return')
          .where('userId', isEqualTo: userID)
          .get();
      final returnList = querySnapshot.docs
          .map(
            (doc) => ReturnModel.fromJson(doc.data()),
          )
          .toList();
      final productSnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      List<Product> returnedProductList = [];
      for (var i = 0; i < returnList.length; i++) {
        returnedProductList = productSnapshot.docs
            .map(
              (doc) => Product.fromJson(doc.data()),
            )
            .where((product) => returnList[i].productId.contains(product.id!))
            .toList();
      }
      emit(ReturnsState(
          returnList: returnList, returnedProductList: returnedProductList));
    });
  }
}
