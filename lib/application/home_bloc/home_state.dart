part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  final List<DocumentSnapshot> document;
  final List<Product> productList;

  const HomeState(this.document, this.productList);
}

class HomeInitial extends HomeState {
  const HomeInitial(super.document, super.productList);
}
