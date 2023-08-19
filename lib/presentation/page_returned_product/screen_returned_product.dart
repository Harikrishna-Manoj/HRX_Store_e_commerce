import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/return.dart';
import 'package:hrx_store/presentation/page_returned_product/widgets.dart';

import '../../core/Model/product.dart';
import '../../core/constant.dart';
import '../../services/order_service/order_service.dart';

class ScreenReturnedProduct extends StatelessWidget {
  const ScreenReturnedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Returns',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left,
              size: 35,
            )),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: FutureBuilder<QuerySnapshot>(
            future: OrderService.getProductIdFromReturnList(),
            builder: (context, activeSnapshot) {
              if (activeSnapshot.connectionState == ConnectionState.waiting) {
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
                final returnList = activeSnapshot.data!.docs
                    .map(
                      (doc) => ReturnModel.fromJson(
                          doc.data() as Map<String, dynamic>),
                    )
                    .toList();
                return FutureBuilder<QuerySnapshot>(
                    future: OrderService.getProducts(),
                    builder: (context, productSnapshot) {
                      if (productSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return ReturnShimmer(size: size);
                      }
                      if (productSnapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                      if (productSnapshot.hasData) {
                        // print(returnList);
                        return returnList.isNotEmpty
                            ? ListView.separated(
                                itemCount: returnList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  List<Product> returnedProductList =
                                      productSnapshot.data!.docs
                                          .map(
                                            (doc) => Product.fromJson(doc.data()
                                                as Map<String, dynamic>),
                                          )
                                          .where((product) => returnList[index]
                                              .productId
                                              .contains(product.id!))
                                          .toList();
                                  return ReturnedProductCard(
                                      imageUrl:
                                          returnedProductList[0].imageurl!,
                                      productName: returnedProductList[0].name,
                                      productSize: returnedProductList[0].size!,
                                      color: returnedProductList[0].color!,
                                      productId: returnList[index].productId,
                                      price: returnedProductList[0]
                                          .price
                                          .toString());
                                },
                                separatorBuilder: (context, index) => kHeight10,
                              )
                            : const Center(
                                child: Text('No returns'),
                              );
                      }
                      return const Center(
                        child: Text('No returns'),
                      );
                    });
              }
              return const Center(
                child: Text('No returns'),
              );
            }),
      ),
    );
  }
}
