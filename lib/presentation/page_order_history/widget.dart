import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_product_detail/screem_product_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HistoryProductCard extends StatelessWidget {
  const HistoryProductCard({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productSize,
    required this.count,
    required this.orderId,
    required this.orderDate,
    required this.orderStatus,
    required this.color,
    required this.productId,
    required this.price,
  });
  final String imageUrl;
  final String productName;
  final String productSize;
  final String count;
  final String orderId;
  final String orderDate;
  final String orderStatus;
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '$productName  ₹$price',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Quantity: $count',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Row(
                      children: [
                        Text(
                          'Size : $productSize, ',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          orderStatus,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Colour: $color, ',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          orderDate,
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class OrderHistoryShimmer extends StatelessWidget {
  const OrderHistoryShimmer({
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
