import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';

class ScreenOrderTracker extends StatelessWidget {
  const ScreenOrderTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TextDto> orderList = [
      TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: OrderTracker(
          status: Status.delivered,
          activeColor: Colors.green,
          inActiveColor: Colors.grey[300],
          orderTitleAndDateList: orderList,
          shippedTitleAndDateList: shippedList,
          outOfDeliveryTitleAndDateList: outOfDeliveryList,
          deliveredTitleAndDateList: deliveredList,
        ),
      ),
    );
  }
}
