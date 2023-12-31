class OrderModel {
  String? orderId;
  dynamic productId;
  int? totalValue;
  String? addressId;
  String? paymentMethod;
  String? orderStatus;
  String? orderDate;
  String? userId;
  int? count;
  OrderModel(
      {this.orderId,
      required this.productId,
      required this.totalValue,
      required this.addressId,
      this.paymentMethod,
      this.count,
      required this.userId,
      this.orderStatus,
      this.orderDate});
  static OrderModel fromJason(Map<String, dynamic> json) => OrderModel(
      userId: json['userId'],
      orderId: json['orderId'],
      productId: json['productId'],
      addressId: json['addressId'],
      totalValue: json['totalValue'],
      paymentMethod: json['paymentMethod'],
      orderStatus: json['orderStatus'],
      orderDate: json['orderDate'],
      count: json['count']);

  Map<String, dynamic> toJason() => {
        'userId': userId,
        'orderId': orderId,
        'productId': productId,
        'addressId': addressId,
        'totalValue': totalValue,
        'paymentMethode': paymentMethod,
        'orderStatus': orderStatus,
        'orderDate': orderDate,
      };
}
