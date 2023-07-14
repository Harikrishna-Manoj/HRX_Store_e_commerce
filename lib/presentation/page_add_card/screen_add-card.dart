import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_add_card/widget.dart';

import '../../core/constant.dart';

class ScreenAddCard extends StatelessWidget {
  const ScreenAddCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Row(
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
                const Text('Add your card',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ],
            ),
          ),
          const CardLayout()
        ]),
      )),
    );
  }
}
