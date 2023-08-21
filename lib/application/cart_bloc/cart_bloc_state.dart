part of 'cart_bloc_bloc.dart';

class CartBlocState {
  final List<Product> cartProductList;
  CartBlocState({required this.cartProductList});
}

final class CartBlocInitial extends CartBlocState {
  CartBlocInitial({super.cartProductList = const []});
}
