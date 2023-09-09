import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrx_store/core/Model/product.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../services/wishlist_service/wishlist_service.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistInitial()) {
    final userId = FirebaseAuth.instance.currentUser!.email;
    on<GetAllWishedProducts>((event, emit) async {
      emit(const WishlistState(wishList: [], isLoading: true));
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .get();
      final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
      List<WishlistProduct> wishlistProducts =
          WishlistService.convertToProductsList(docs);
      emit(WishlistState(wishList: wishlistProducts, isLoading: false));
    });
    on<DeleteProductFromWishlist>((event, emit) async {
      try {
        final cartCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('wishlist')
            .doc(event.id);
        await cartCollection.delete();
        // ignore: use_build_context_synchronously
        Fluttertoast.showToast(msg: 'Removed from wishlist');
        add(GetAllWishedProducts());
      } catch (e) {
        // print(e.toString());
        Fluttertoast.showToast(msg: e.toString());
      }
    });
  }
}
