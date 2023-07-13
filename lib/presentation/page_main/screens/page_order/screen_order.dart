import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_main/screens/page_order/widget.dart';

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
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const OrderProductCard();
                        },
                        separatorBuilder: (context, index) => kHeight10,
                        itemCount: 10),
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
