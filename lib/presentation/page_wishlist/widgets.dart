import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/wishlist_bloc/wishlist_bloc.dart';
import 'package:hrx_store/presentation/page_product_detail/screem_product_detail.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:text_scroll/text_scroll.dart';

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.category,
    required this.id,
  });
  final String imageUrl;
  final String name;
  final String price;
  final String category;
  final String id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: ScreenProductDetails(id: id),
                type: PageTransitionType.rightToLeft));
      },
      child: Card(
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
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.45,
                      child: TextScroll(
                        name,
                        mode: TextScrollMode.endless,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(30, 0)),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Text(
                      category,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                    Text(
                      "₹ $price",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
                IconButton(
                    tooltip: 'Delete product',
                    onPressed: () {
                      showBottomSheet(
                        // elevation: 20,
                        context: context,
                        builder: (context) {
                          return Container(
                            color: Colors.grey[100],
                            width: size.width,
                            height: 55,
                            child: TextButton.icon(
                                onPressed: () {
                                  BlocProvider.of<WishlistBloc>(context)
                                      .add(DeleteProductFromWishlist(id: id));
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                                label: const Text(
                                  'Remove from wishlist',
                                  style: TextStyle(color: Colors.black),
                                )),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.highlight_remove_sharp,
                    ))
              ],
            )),
      ),
    );
  }
}

class WishListShimmer extends StatelessWidget {
  const WishListShimmer({
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
