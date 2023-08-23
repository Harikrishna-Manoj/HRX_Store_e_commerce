part of 'order_bloc.dart';

@immutable
class OrderState {
  final List<OrderModel> orderList;
  final List<Product> orderProductList;

  const OrderState({required this.orderList, required this.orderProductList});
}

final class OrderInitial extends OrderState {
  const OrderInitial(
      {super.orderList = const [], super.orderProductList = const []});
}
