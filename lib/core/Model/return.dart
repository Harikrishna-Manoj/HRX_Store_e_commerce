class ReturnModel {
  String userId = '';
  String returnId = '';
  String productId = '';
  String reason = '';
  String orderId = '';
  ReturnModel(
      {required this.orderId,
      required this.productId,
      required this.reason,
      required this.returnId,
      required this.userId});
  static ReturnModel fromJson(Map<String, dynamic> json) => ReturnModel(
      orderId: json['orderId'],
      productId: json['productId'],
      reason: json['reason'],
      returnId: json['returnId'],
      userId: json['userId']);
}
