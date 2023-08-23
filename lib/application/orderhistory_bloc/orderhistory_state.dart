part of 'orderhistory_bloc.dart';

@immutable
class OrderhistoryState {
  final List<OrderModel> orderList;
  final List<Product> orderProductList;

  const OrderhistoryState(
      {required this.orderList, required this.orderProductList});
}

class OrderhistoryInitial extends OrderhistoryState {
  const OrderhistoryInitial(
      {super.orderList = const [], super.orderProductList = const []});
}
