part of 'product_bloc.dart';

@immutable
class ProductState {
  final List<String> imageUrl;
  final String image;
  final int price;
  final String category;
  final String name;
  const ProductState(
      {required this.image,
      required this.price,
      required this.category,
      required this.name,
      required this.imageUrl});
}

class ProductInitial extends ProductState {
  const ProductInitial(
      {super.imageUrl = const [],
      super.image = '',
      super.price = 0,
      super.category = '',
      super.name = ''});
}
