part of 'orderhistory_bloc.dart';

@immutable
class OrderhistoryState {
  final List<OrderModel> orderList;
  final List<Product> orderProductList;
  final bool isLoading;

  const OrderhistoryState(
      {required this.orderList,
      required this.orderProductList,
      required this.isLoading});
}

class OrderhistoryInitial extends OrderhistoryState {
  const OrderhistoryInitial(
      {super.orderList = const [],
      super.orderProductList = const [],
      super.isLoading = false});
}
