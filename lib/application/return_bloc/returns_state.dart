part of 'returns_bloc.dart';

@immutable
class ReturnsState {
  final List<ReturnModel> returnList;
  final List<Product> returnedProductList;

  const ReturnsState(
      {required this.returnList, required this.returnedProductList});
}

class ReturnsInitial extends ReturnsState {
  const ReturnsInitial(
      {super.returnList = const [], super.returnedProductList = const []});
}
