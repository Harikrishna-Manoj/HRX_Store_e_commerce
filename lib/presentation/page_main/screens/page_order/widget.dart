import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrx_store/application/order_bloc/order_bloc.dart';
import 'package:hrx_store/presentation/page_order_tracker/screen_order_tracker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:text_scroll/text_scroll.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard({
    super.key,
    required this.color,
    required this.productName,
    required this.count,
    required this.productSize,
    required this.imageUrl,
    required this.orderId,
    required this.orderStatus,
    required this.orderDate,
    required this.price,
    required this.userId,
    required this.productId,
  });
  final String color;
  final String productName;
  final String count;
  final String productSize;
  final String imageUrl;
  final String orderId;
  final String orderStatus;
  final String orderDate;
  final String price;
  final String userId;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final reasonController = TextEditingController();
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child:
                    ScreenOrderTracker(orderId: orderId, orderDate: orderDate),
                type: PageTransitionType.fade));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Container(
          width: size.width,
          height: size.height * 0.20,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 4, right: 15),
                    height: size.height * 0.12,
                    width: size.width * .23,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(13)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.3,
                          child: TextScroll(
                            productName,
                            mode: TextScrollMode.endless,
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(30, 0)),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Text(
                          'Quantity: $count',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Size : $productSize',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Colour: $color',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'Date: $orderDate',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: size.width * 0.3,
                          child: TextScroll(
                            orderStatus,
                            mode: TextScrollMode.endless,
                            velocity:
                                const Velocity(pixelsPerSecond: Offset(30, 0)),
                            style: TextStyle(
                                color: orderStatus == 'returned'
                                    ? Colors.red
                                    : orderStatus == 'requested'
                                        ? Colors.blue
                                        : Colors.green),
                          ),
                        ),
                        Text(
                          '₹ $price',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              orderStatus == 'delivered'
                  ? Positioned(
                      right: 30,
                      top: size.height * 0.14 / 2,
                      child: IconButton(
                          tooltip: 'return product',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                    'Do you want to return this product ?',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                content: ReasonField(
                                    reasonController: reasonController),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        if (reasonController.text.isNotEmpty) {
                                          BlocProvider.of<OrderBloc>(context)
                                              .add(ReturnOrder(
                                                  userId: userId,
                                                  productId: productId,
                                                  reason: reasonController.text,
                                                  orderId: orderId));
                                          Navigator.pop(context);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: 'Reason required');
                                        }
                                      },
                                      child: const Text('Yes',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red)))
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.replay_rounded)),
                    )
                  : orderStatus == 'returned'
                      ? Positioned(
                          right: 20,
                          top: size.height * 0.17 / 2,
                          child: const Text(
                            'Returned',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        )
                      : orderStatus == 'requested'
                          ? Positioned(
                              right: 20,
                              top: size.height * 0.17 / 2,
                              child: const Text(
                                'Requested',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Positioned(
                              right: 30,
                              top: size.height * 0.14 / 2,
                              child: IconButton(
                                tooltip: 'Cancel order',
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Do you want to cancel ?',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Don't cancel",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              BlocProvider.of<OrderBloc>(
                                                      context)
                                                  .add(CancelOrder(
                                                      orderId: orderId));
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Canel order',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red)))
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            )
            ],
          ),
        ),
      ),
    );
  }
}

class ReasonField extends StatelessWidget {
  const ReasonField({
    super.key,
    required this.reasonController,
  });

  final TextEditingController reasonController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: reasonController,
      decoration: const InputDecoration(labelText: 'Reason for return'),
    );
  }
}

class OrderShimmer extends StatelessWidget {
  const OrderShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Container(
            width: size.width,
            height: size.height * 0.20,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Shimmer(
                  color: Colors.black,
                  child: Container(
                    margin: const EdgeInsets.only(left: 4, right: 15),
                    height: size.height * 0.12,
                    width: size.width * .23,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(13)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 5,
                            width: 80,
                          )),
                    ),
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 5,
                            width: 80,
                          )),
                    ),
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 5,
                            width: 80,
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
