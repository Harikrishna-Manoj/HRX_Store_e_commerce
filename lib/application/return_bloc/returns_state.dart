part of 'returns_bloc.dart';

@immutable
class ReturnsState {
  final List<ReturnModel> returnList;
  final List<Product> returnedProductList;
  final isLoading;

  const ReturnsState(
      {required this.returnList,
      required this.returnedProductList,
      required this.isLoading});
}

class ReturnsInitial extends ReturnsState {
  const ReturnsInitial(
      {super.returnList = const [],
      super.returnedProductList = const [],
      super.isLoading = false});
}
