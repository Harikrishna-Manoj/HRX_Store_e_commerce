import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/order_bloc/order_bloc.dart';

import 'package:hrx_store/presentation/page_main/screens/page_order/widget.dart';

import '../../../../core/constant.dart';

class ScreenOrder extends StatelessWidget {
  const ScreenOrder({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<OrderBloc>(context).add(GetAllOrders());
    });
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
                    child: BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                      return state.isLoading == true
                          ? OrderShimmer(size: size)
                          : state.orderList.isNotEmpty
                              ? ListView.separated(
                                  itemCount: state.orderList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return OrderProductCard(
                                        productId:
                                            state.orderList[index].productId,
                                        userId: state.orderList[index].userId!,
                                        price: state.orderProductList[0].price
                                            .toString(),
                                        orderStatus:
                                            state.orderList[index].orderStatus!,
                                        orderDate:
                                            state.orderList[index].orderDate!,
                                        orderId:
                                            state.orderList[index].orderId!,
                                        color: state.orderProductList[0].color!,
                                        productName:
                                            state.orderProductList[0].name,
                                        count: state.orderList[index].count
                                            .toString(),
                                        productSize:
                                            state.orderProductList[0].size!,
                                        imageUrl: state
                                            .orderProductList[0].imageurl!);
                                  },
                                  separatorBuilder: (context, index) =>
                                      kHeight10,
                                )
                              : const Center(
                                  child: Text('No orders'),
                                );
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
