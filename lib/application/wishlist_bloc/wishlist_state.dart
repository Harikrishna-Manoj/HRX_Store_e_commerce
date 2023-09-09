part of 'wishlist_bloc.dart';

@immutable
class WishlistState {
  final List<WishlistProduct> wishList;
  final bool isLoading;

  const WishlistState({required this.wishList, required this.isLoading});
}

final class WishlistInitial extends WishlistState {
  const WishlistInitial({super.wishList = const [], super.isLoading = false});
}
