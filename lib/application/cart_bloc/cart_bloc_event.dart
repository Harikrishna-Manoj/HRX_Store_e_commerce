part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartBlocEvent {}

class GetAllCartProduct extends CartBlocEvent {}

class DeleteFromCart extends CartBlocEvent {
  final String productId;
  DeleteFromCart({required this.productId});
}
