part of 'order_bloc.dart';

@immutable
class OrderState {
  final List<OrderModel> orderList;
  final List<Product> orderProductList;
  final bool isLoading;
  const OrderState({
    required this.orderList,
    required this.orderProductList,
    required this.isLoading,
  });
}

final class OrderInitial extends OrderState {
  const OrderInitial(
      {super.orderList = const [],
      super.orderProductList = const [],
      super.isLoading = false});
}
