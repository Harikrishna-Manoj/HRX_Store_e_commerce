import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:hrx_store/presentation/page_categories/screen_listed_category_product.dart';
import 'package:hrx_store/presentation/page_categories/widgets.dart';
import 'package:hrx_store/services/search_service/search_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../core/constant.dart';

class ScreenCategories extends StatelessWidget {
  const ScreenCategories({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    List<Product> shoes = [];
    List<Product> clothes = [];
    List<Product> bags = [];
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
          child: SingleChildScrollView(
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
                StreamBuilder(
                    stream: SeacrchService.getProducts(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            kHeight30,
                            kHeight30,
                            Card(
                              child: Shimmer(
                                color: Colors.black,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            kHeight30,
                            Card(
                              child: Shimmer(
                                color: Colors.black,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            kHeight30,
                            Card(
                              child: Shimmer(
                                color: Colors.black,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      List<DocumentSnapshot> document = snapshot.data;
                      List<Product> productList =
                          SeacrchService.convertToProductsList(document);
                      for (var product in productList) {
                        if (product.category == 'Shoes') {
                          shoes.add(product);
                        } else if (product.category == 'Cloths') {
                          clothes.add(product);
                        } else if (product.category == 'Bags') {
                          bags.add(product);
                        }
                      }
                      // print(shoes);
                      // print(clothes);
                      return Column(
                        children: [
                          kHeight30,
                          kHeight30,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: ScreenListedCategory(
                                          products: shoes, title: 'Shoes'),
                                      type: PageTransitionType.rightToLeft));
                            },
                            child: const CategoryCard(
                                imageUrl: 'asset/images/category1.webp',
                                heading: 'Shoes'),
                          ),
                          kHeight30,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: ScreenListedCategory(
                                          products: clothes, title: 'Cloths'),
                                      type: PageTransitionType.rightToLeft));
                            },
                            child: const CategoryCard(
                                imageUrl: 'asset/images/category2.webp',
                                heading: 'Cloths'),
                          ),
                          kHeight30,
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: ScreenListedCategory(
                                          products: bags, title: 'Bags'),
                                      type: PageTransitionType.rightToLeft));
                            },
                            child: const CategoryCard(
                                imageUrl: 'asset/images/category3.jpeg',
                                heading: 'Bags'),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
