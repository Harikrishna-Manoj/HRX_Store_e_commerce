import 'package:flutter/material.dart';

import 'package:hrx_store/services/order_service/order_service.dart';
import 'package:order_tracker/order_tracker.dart';

// ignore: must_be_immutable
class ScreenOrderTracker extends StatelessWidget {
  ScreenOrderTracker({Key? key, required this.orderId, required this.orderDate})
      : super(key: key);
  final String orderId;
  final String orderDate;
  ValueNotifier statusNotifer = ValueNotifier(0);
  final statusList = [
    Status.order,
    Status.shipped,
    Status.outOfDelivery,
    Status.delivered
  ];
  @override
  Widget build(BuildContext context) {
    List<TextDto> orderList = [
      TextDto("Your order has been placed", orderDate),
      TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
      TextDto("Your item has been picked up by courier partner.",
          "Tue, 29th Mar '22 - 5:00pm"),
    ];

    List<TextDto> shippedList = [
      TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
      TextDto("Your item has been received in the nearest hub to you.", null),
    ];

    List<TextDto> outOfDeliveryList = [
      TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
    ];

    List<TextDto> deliveredList = [
      TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Order Tracker",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left,
              size: 35,
            )),
      ),
      body: FutureBuilder(
          future: OrderService.getOrderedProduct(orderId),
          builder: (context, trackSnapshot) {
            if (trackSnapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            if (trackSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
                ),
              );
            }
            final status = trackSnapshot.data!['orderStatus'];
            if (status == 'placed') {
              statusNotifer.value = 0;
            } else if (status == 'shipped') {
              statusNotifer.value = 1;
            } else if (status == 'out for delivery') {
              statusNotifer.value = 2;
            } else if (status == 'delivered') {
              statusNotifer.value = 3;
            }
            return ValueListenableBuilder(
                valueListenable: statusNotifer,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: OrderTracker(
                      status: statusList[value],
                      activeColor: Colors.green,
                      inActiveColor: Colors.grey[300],
                      orderTitleAndDateList: orderList,
                      shippedTitleAndDateList: shippedList,
                      outOfDeliveryTitleAndDateList: outOfDeliveryList,
                      deliveredTitleAndDateList: deliveredList,
                    ),
                  );
                });
          }),
    );
  }
}
