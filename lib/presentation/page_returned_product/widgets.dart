import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../page_product_detail/screem_product_detail.dart';

class ReturnedProductCard extends StatelessWidget {
  const ReturnedProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productSize,
    required this.color,
    required this.productId,
    required this.price,
  });
  final String imageUrl;
  final String productName;
  final String productSize;

  final String color;
  final String productId;
  final String price;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            PageTransition(
                child: ScreenProductDetails(id: productId),
                type: PageTransitionType.fade)),
        child: Container(
            width: size.width,
            height: size.height * 0.13,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 15),
                  height: size.height * 0.12,
                  width: size.width * .23,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(13)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Size : $productSize',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Text(
                      'Returned',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₹ $price',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class ReturnShimmer extends StatelessWidget {
  const ReturnShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Container(
            width: size.width,
            height: size.height * 0.13,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Shimmer(
                  color: Colors.black,
                  child: Container(
                    margin: const EdgeInsets.only(left: 4, right: 15),
                    height: size.height * 0.12,
                    width: size.width * .23,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(13)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 5,
                            width: 80,
                          )),
                    ),
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 5,
                            width: 80,
                          )),
                    ),
                    Shimmer(
                      color: Colors.black,
                      child: const Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 5),
                          child: SizedBox(
                            height: 5,
                            width: 80,
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
