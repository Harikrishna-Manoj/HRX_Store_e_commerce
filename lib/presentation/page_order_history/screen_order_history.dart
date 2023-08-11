import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_order_history/widget.dart';

import '../../core/Model/order.dart';
import '../../core/Model/product.dart';
import '../../core/constant.dart';
import '../../services/order_service/order_service.dart';

class ScreenOrderHistory extends StatelessWidget {
  const ScreenOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_circle_left_rounded,
            size: largeFont,
          ),
        ),
        title: const Text('Order History',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.89,
                  width: size.width,
                  child: FutureBuilder<QuerySnapshot>(
                      future: OrderService.getProductIdFromOrdersCompleted(),
                      builder: (context, activeSnapshot) {
                        if (activeSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return OrderHistoryShimmer(size: size);
                        }
                        if (activeSnapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (activeSnapshot.hasData) {
                          final orderList = activeSnapshot.data!.docs
                              .map(
                                (doc) => OrderModel.fromJason(
                                    doc.data() as Map<String, dynamic>),
                              )
                              .toList();
                          return FutureBuilder<QuerySnapshot>(
                              future: OrderService.getProducts(),
                              builder: (context, productSnapshot) {
                                if (productSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return OrderHistoryShimmer(size: size);
                                }
                                if (productSnapshot.hasError) {
                                  return const Center(
                                    child: Text('Something went wrong'),
                                  );
                                }
                                if (productSnapshot.hasData) {
                                  // print(orderList);
                                  return orderList.isNotEmpty
                                      ? ListView.separated(
                                          itemCount: orderList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            List<Product> orderProductList =
                                                productSnapshot.data!.docs
                                                    .map(
                                                      (doc) => Product.fromJson(
                                                          doc.data() as Map<
                                                              String, dynamic>),
                                                    )
                                                    .where((product) =>
                                                        orderList[index]
                                                            .productId!
                                                            .contains(
                                                                product.id))
                                                    .toList();

                                            return HistoryProductCard(
                                                price: orderProductList[0]
                                                    .price
                                                    .toString(),
                                                productId:
                                                    orderList[index].productId!,
                                                orderStatus: orderList[index]
                                                    .orderStatus!,
                                                orderDate:
                                                    orderList[index].orderDate!,
                                                orderId:
                                                    orderList[index].orderId!,
                                                color:
                                                    orderProductList[0].color!,
                                                productName:
                                                    orderProductList[0].name,
                                                count: orderList[index]
                                                    .count
                                                    .toString(),
                                                productSize:
                                                    orderProductList[0].size!,
                                                imageUrl: orderProductList[0]
                                                    .imageurl!);
                                          },
                                          separatorBuilder: (context, index) =>
                                              kHeight10,
                                        )
                                      : const Center(
                                          child: Text('No delivered products'),
                                        );
                                }
                                return const Center(
                                  child: Text('No delivered products'),
                                );
                              });
                        }
                        return const Center(
                          child: Text('No delivered products'),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
