part of 'categories_bloc.dart';

@immutable
class CategoriesState {
  final List<Product> shoes;
  final List<Product> clothes;
  final List<Product> bags;

  const CategoriesState(
      {required this.clothes, required this.bags, required this.shoes});
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial({
    super.shoes = const [],
    super.clothes = const [],
    super.bags = const [],
  });
}
