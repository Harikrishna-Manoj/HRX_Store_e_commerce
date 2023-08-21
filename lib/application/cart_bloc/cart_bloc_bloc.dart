import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:meta/meta.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBlocBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBlocBloc() : super(CartBlocInitial()) {
    on<GetAllCartProduct>((event, emit) async {
      final userId = FirebaseAuth.instance.currentUser!.email;
      final querySnapShot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();
      List<dynamic> productId =
          querySnapShot.docs.map((doc) => doc.get('productid')).toList();
      final cartQuerySnapShot =
          await FirebaseFirestore.instance.collection('product').get();
      List<Product> productList = cartQuerySnapShot.docs
          .map((doc) => Product.fromJson(doc.data()))
          .where((product) => productId.contains(product.id))
          .toList();
      emit(CartBlocState(cartProductList: productList));
    });
    on<DeleteFromCart>((event, emit) async {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        final userId = currentUser!.email;
        final cartCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(event.productId);
        await cartCollection.delete();
        // ignore: use_build_context_synchronously
        Fluttertoast.showToast(msg: 'Removed from cart');
      } catch (e) {
        // print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    });
  }
}
