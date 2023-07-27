import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_add_deabitcard/widget.dart';

import '../../core/constant.dart';

class ScreenAddCard extends StatelessWidget {
  const ScreenAddCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Add debit card',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left,
              size: 35,
            )),
      ),
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: const Column(
            children: [
              CardLayout(),
            ],
          ),
        ),
      ),
    );
  }
}
