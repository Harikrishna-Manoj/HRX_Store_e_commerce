part of 'wishlist_bloc.dart';

@immutable
class WishlistEvent {}

class GetAllWishedProducts extends WishlistEvent {}

class DeleteProductFromWishlist extends WishlistEvent {
  final String id;

  DeleteProductFromWishlist({required this.id});
}
