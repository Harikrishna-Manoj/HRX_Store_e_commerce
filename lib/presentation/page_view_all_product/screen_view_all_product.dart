import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_view_all_product/widget.dart';

import '../../core/constant.dart';

class ScreenViewAllProduct extends StatelessWidget {
  const ScreenViewAllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              pinned: true,
              elevation: 0,
              expandedHeight: size.height * 0.09,
              flexibleSpace: FlexibleSpaceBar(
                background: ListView(
                  children: [
                    kHeight10,
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_circle_left_rounded,
                            size: largeFont,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('All Products',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([const AllGridProducts()]))
          ],
        ),
      )),
    );
  }
}
