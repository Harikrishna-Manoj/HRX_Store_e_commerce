import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/order.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:hrx_store/presentation/page_main/screens/page_order/widget.dart';
import 'package:hrx_store/services/order_service/order_service.dart';

import '../../../../core/constant.dart';

class ScreenOrder extends StatelessWidget {
  const ScreenOrder({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10,
              ),
              child: Column(
                children: [
                  kHeight10,
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text('My Order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .8,
                    width: size.width,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('orders')
                            .snapshots(),
                        builder: (context, snapshot) {
                          return FutureBuilder<QuerySnapshot>(
                              future:
                                  OrderService.getProductIdFromOrdersActive(),
                              builder: (context, activeSnapshot) {
                                if (activeSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  );
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
                                          return OrderShimmer(size: size);
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    List<Product>
                                                        orderProductList =
                                                        productSnapshot
                                                            .data!.docs
                                                            .map(
                                                              (doc) => Product
                                                                  .fromJson(doc
                                                                          .data()
                                                                      as Map<
                                                                          String,
                                                                          dynamic>),
                                                            )
                                                            .where((product) =>
                                                                orderList[index]
                                                                    .productId!
                                                                    .contains(
                                                                        product
                                                                            .id))
                                                            .toList();

                                                    return OrderProductCard(
                                                        productId: orderList[index]
                                                            .productId,
                                                        userId: orderList[index]
                                                            .userId!,
                                                        price: orderProductList[
                                                                0]
                                                            .price
                                                            .toString(),
                                                        orderStatus: orderList[
                                                                index]
                                                            .orderStatus!,
                                                        orderDate: orderList[
                                                                index]
                                                            .orderDate!,
                                                        orderId:
                                                            orderList[index]
                                                                .orderId!,
                                                        color:
                                                            orderProductList[
                                                                    0]
                                                                .color!,
                                                        productName:
                                                            orderProductList[
                                                                    0]
                                                                .name,
                                                        count:
                                                            orderList[
                                                                    index]
                                                                .count
                                                                .toString(),
                                                        productSize:
                                                            orderProductList[0]
                                                                .size!,
                                                        imageUrl:
                                                            orderProductList[0]
                                                                .imageurl!);
                                                  },
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          kHeight10,
                                                )
                                              : const Center(
                                                  child: Text(
                                                      'No delivered products'),
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
                              });
                        }),
                  ),
                  kHeight30,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
