import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_order_history/widget.dart';

import '../../core/constant.dart';

class ScreenOrderHistory extends StatelessWidget {
  const ScreenOrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.arrow_circle_left_rounded,
                            size: largeFont,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: size.width * .15),
                          child: const Text('Order History',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.89,
                      width: size.width,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return const HistoryProductCard();
                          },
                          separatorBuilder: (context, index) => kHeight10,
                          itemCount: 10),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
