part of 'order_bloc.dart';

@immutable
class OrderEvent {}

class GetAllOrders extends OrderEvent {}

class CancelOrder extends OrderEvent {
  final String orderId;

  CancelOrder({required this.orderId});
}

class ReturnOrder extends OrderEvent {
  final String orderId;
  final String userId;
  final String productId;
  final String reason;
  ReturnOrder(
      {required this.userId,
      required this.productId,
      required this.reason,
      required this.orderId});
}
