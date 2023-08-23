import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/orderhistory_bloc/orderhistory_bloc.dart';
import 'package:hrx_store/presentation/page_order_history/widget.dart';

import '../../core/constant.dart';

class ScreenOrderHistory extends StatelessWidget {
  const ScreenOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<OrderhistoryBloc>(context).add(GetAllOrderHistory());
    });
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
                  child: BlocBuilder<OrderhistoryBloc, OrderhistoryState>(
                      builder: (context, state) {
                    return state.orderList.isNotEmpty
                        ? ListView.separated(
                            itemCount: state.orderList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return HistoryProductCard(
                                  price: state.orderProductList[0].price
                                      .toString(),
                                  productId: state.orderList[index].productId!,
                                  orderStatus:
                                      state.orderList[index].orderStatus!,
                                  orderDate: state.orderList[index].orderDate!,
                                  orderId: state.orderList[index].orderId!,
                                  color: state.orderProductList[0].color!,
                                  productName: state.orderProductList[0].name,
                                  count:
                                      state.orderList[index].count.toString(),
                                  productSize: state.orderProductList[0].size!,
                                  imageUrl:
                                      state.orderProductList[0].imageurl!);
                            },
                            separatorBuilder: (context, index) => kHeight10,
                          )
                        : const Center(
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
