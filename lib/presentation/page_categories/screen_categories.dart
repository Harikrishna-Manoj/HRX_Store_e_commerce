import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_categories/widgets.dart';

import '../../core/constant.dart';

class ScreenCategories extends StatelessWidget {
  const ScreenCategories({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  Padding(
                    padding: EdgeInsets.only(left: size.width * .15),
                    child: const Text('Categories',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
              kHeight30,
              kHeight30,
              const CategoryCard(
                  imageUrl: 'asset/images/category1.webp', heading: 'Shoes'),
              kHeight30,
              const CategoryCard(
                  imageUrl: 'asset/images/category2.webp', heading: 'Clothes'),
              kHeight30,
              const CategoryCard(
                  imageUrl: 'asset/images/category3.jpeg', heading: 'Bags'),
            ],
          ),
        ),
      )),
    );
  }
}
