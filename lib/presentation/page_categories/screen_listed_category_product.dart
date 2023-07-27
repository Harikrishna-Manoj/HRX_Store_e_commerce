import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:hrx_store/presentation/page_categories/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:text_scroll/text_scroll.dart';

import '../page_product_detail/screem_product_detail.dart';

class ScreenListedCategory extends StatelessWidget {
  const ScreenListedCategory(
      {super.key, required this.title, required this.products});
  final String title;
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_circle_left,
                size: 35,
              )),
        ),
        body: SizedBox(
            height: size.height,
            width: size.width,
            child: products.isNotEmpty
                ? GridView.count(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1 / 1.45,
                    children: List.generate(
                        products.length,
                        (index) => Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // print(productList[index].id);
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: ScreenProductDetails(
                                                  id: products[index].id!),
                                              type: PageTransitionType.fade));
                                    },
                                    child: Card(
                                      elevation: 3,
                                      child: SizedBox(
                                        width: size.width * 0.6,
                                        height: size.height * 0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(children: [
                                              Container(
                                                width: size.width * 0.45,
                                                height: size.width * 0.45,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    products[index].imageurl!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              FavouriteButton(
                                                id: products[index].id!,
                                                amount: products[index]
                                                    .price!
                                                    .toString(),
                                                name: products[index].name,
                                                imageurl:
                                                    products[index].imageurl!,
                                                category:
                                                    products[index].category!,
                                              ),
                                            ]),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 5),
                                              child: TextScroll(
                                                products[index].name,
                                                mode: TextScrollMode.endless,
                                                velocity: const Velocity(
                                                    pixelsPerSecond:
                                                        Offset(30, 0)),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 5),
                                              child: Text(
                                                "Size : ${products[index].size!}",
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, top: 5),
                                              child: Text(
                                                'Rate : ₹${products[index].price}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )))
                : const Center(
                    child: Text('No product'),
                  )));
  }
}
