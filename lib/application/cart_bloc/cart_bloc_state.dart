part of 'cart_bloc_bloc.dart';

class CartBlocState {
  final List<Product> cartProductList;
  final bool isLoading;
  CartBlocState({
    required this.isLoading,
    required this.cartProductList,
  });
}

final class CartBlocInitial extends CartBlocState {
  CartBlocInitial({super.cartProductList = const [], super.isLoading = false});
}
