import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_view_all_product/widget.dart';

class ScreenViewAllProduct extends StatelessWidget {
  const ScreenViewAllProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'All products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left_rounded,
              size: 35,
            )),
      ),
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: const SingleChildScrollView(
          child: Column(
            children: [AllGridProducts()],
          ),
        ),
      )),
    );
  }
}
