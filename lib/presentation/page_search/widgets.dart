import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../page_product_detail/screem_product_detail.dart';

class GridProducts extends StatelessWidget {
  const GridProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GridView.count(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        childAspectRatio: 1 / 1.45,
        children: List.generate(
            10,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ScreenProductDetails(),
                                  type: PageTransitionType.fade));
                        },
                        child: Card(
                          elevation: 3,
                          child: SizedBox(
                            width: size.width * 0.6,
                            height: size.height * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  Container(
                                    width: size.width * 0.45,
                                    height: size.width * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        'asset/images/LOGO 2.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 110,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.favorite_outline)))
                                ]),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0, top: 5),
                                  child: Text(
                                    'Product name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0, top: 5),
                                  child: Text(
                                    'Category',
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0, top: 5),
                                  child: Text(
                                    'Rate',
                                    style: TextStyle(
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
                )));
  }
}
