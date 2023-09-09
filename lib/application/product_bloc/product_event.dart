part of 'product_bloc.dart';

@immutable
class ProductEvent {}

class GetImages extends ProductEvent {
  final String id;

  GetImages({required this.id});
}

class CheckWishList extends ProductEvent {
  final ValueNotifier wishlistIconChangeNotifer;
  final String id;
  CheckWishList({required this.wishlistIconChangeNotifer, required this.id});
}

class CheckCart extends ProductEvent {
  final ValueNotifier addCartIconChangeNotifer;
  final String id;
  CheckCart({required this.addCartIconChangeNotifer, required this.id});
}
