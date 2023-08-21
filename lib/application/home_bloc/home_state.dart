part of 'home_bloc.dart';

class HomeState {
  final List<Product> productList;

  HomeState({required this.productList});
}

class HomeInitial extends HomeState {
  HomeInitial({super.productList = const []});
}
