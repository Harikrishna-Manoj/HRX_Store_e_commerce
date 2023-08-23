import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/categories_bloc/categories_bloc.dart';
import 'package:hrx_store/presentation/page_categories/screen_listed_category_product.dart';
import 'package:hrx_store/presentation/page_categories/widgets.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/constant.dart';

class ScreenCategories extends StatelessWidget {
  const ScreenCategories({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<CategoriesBloc>(context).add(GetAllCategoryProduct());
    });
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Categories',
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
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
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
                                      products: state.shoes, title: 'Shoes'),
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
                                      products: state.clothes, title: 'Cloths'),
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
                                      products: state.bags, title: 'Bags'),
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
