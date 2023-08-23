part of 'cart_bloc_bloc.dart';

@immutable
class CartBlocEvent {}

class GetAllCartProduct extends CartBlocEvent {}

class IncreaseOrDereaseQuantity extends CartBlocEvent {
  final String productId;
  final bool increase;
  final int price;
  IncreaseOrDereaseQuantity(
      {required this.productId, required this.increase, required this.price});
}

class DeleteFromCart extends CartBlocEvent {
  final String productId;
  DeleteFromCart({required this.productId});
}
