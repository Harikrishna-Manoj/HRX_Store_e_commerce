part of 'wishlist_bloc.dart';

@immutable
class WishlistState {
  final List<WishlistProduct> wishList;

  const WishlistState({required this.wishList});
}

final class WishlistInitial extends WishlistState {
  const WishlistInitial({super.wishList = const []});
}
