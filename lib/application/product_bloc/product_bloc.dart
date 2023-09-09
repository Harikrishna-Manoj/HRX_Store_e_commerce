import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductInitial()) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser!.email;
    on<CheckCart>((event, emit) async {
      final cartSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(event.id)
          .get();

      if (cartSnapshot.exists) {
        event.addCartIconChangeNotifer.value = true;
      } else {
        event.addCartIconChangeNotifer.value = false;
      }
    });
    on<CheckWishList>((event, emit) async {
      final wishlistSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('wishlist')
          .doc(event.id)
          .get();

      if (wishlistSnapshot.exists) {
        event.wishlistIconChangeNotifer.value = true;
      } else {
        event.wishlistIconChangeNotifer.value = false;
      }
    });
    on<GetImages>((event, emit) async {
      emit(const ProductState(
          image: '',
          price: 0,
          category: '',
          name: '',
          imageUrl: [],
          isLoading: true));
      final imageQuery = await FirebaseFirestore.instance
          .collection('product')
          .doc(event.id)
          .get();
      List<String> imageUrl = [];
      imageUrl.add(imageQuery['imageurl']);
      for (var element in imageQuery['multiimage']) {
        imageUrl.add(element);
      }
      emit(ProductState(
          isLoading: false,
          image: imageQuery['imageurl'],
          price: imageQuery['price'],
          category: imageQuery['category'],
          name: imageQuery['name'],
          imageUrl: imageUrl));
    });
  }
}
