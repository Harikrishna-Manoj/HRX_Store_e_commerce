import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_add_card/screen_add-card.dart';
import 'package:hrx_store/presentation/page_categories/screen_categories.dart';
import 'package:hrx_store/presentation/page_product_detail/screem_product_detail.dart';
import 'package:hrx_store/presentation/page_wishlist/screen_wishlist.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/constant.dart';
import '../../../page_search/screen_search.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8, top: 5, bottom: 5),
      child: CupertinoSearchTextField(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const ScreenSearch(), type: PageTransitionType.fade));
        },
        keyboardType: TextInputType.none,
        prefixInsets: const EdgeInsets.only(right: 5, left: 5),
        suffixInsets: const EdgeInsets.only(right: 5, left: 5, top: 2),
        onChanged: (value) {},
        placeholder: 'Search',
        backgroundColor: Colors.black87,
        prefixIcon: Icon(
          CupertinoIcons.search,
          color: searchSuffixColor,
        ),
        suffixIcon: Icon(
          CupertinoIcons.xmark,
          color: searchPrefixColor,
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class SlideIconAndDecarationText extends StatelessWidget {
  const SlideIconAndDecarationText({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideBar(scaffoldKey: _scaffoldKey),
          kHeight10,
          const Text(
            'HRX Store,',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Your Fashion App',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class ViewAllProduct extends StatelessWidget {
  const ViewAllProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          InkWell(
            onTap: () {},
            child: const Text('View All',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )),
          )
        ],
      ),
    );
  }
}

class SlideBar extends StatelessWidget {
  const SlideBar({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: InkWell(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: Image.asset(
          'asset/images/slidericon.png',
          scale: 13,
        ),
      ),
    );
  }
}

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

class TransparentDrawer extends StatelessWidget {
  const TransparentDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          const SizedBox(
            height: 90,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const ScreenWishlist(),
                      type: PageTransitionType.fade));
            },
            child: const DrawerItems(
              iteamIcon: Icons.favorite,
              itemName: "My Wishlist",
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const ScreenAddCard(),
                      type: PageTransitionType.fade));
            },
            child: const DrawerItems(
              iteamIcon: Icons.credit_card,
              itemName: "My Card",
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const ScreenCategories(),
                      type: PageTransitionType.fade));
            },
            child: const DrawerItems(
              iteamIcon: Icons.list,
              itemName: "Category",
            ),
          ),
          kHeight30,
          const Divider(),
          kHeight30,
          const DrawerItems(
            itemName: "Terms & Condition",
          ),
          const DrawerItems(
            itemName: "Share App",
          ),
          const DrawerItems(
            itemName: "Exit",
          ),
        ],
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  const DrawerItems({
    super.key,
    required this.itemName,
    this.iteamIcon,
  });
  final IconData? iteamIcon;
  final String itemName;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Card(
      elevation: 3,
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Icon(iteamIcon),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              itemName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class Indicators extends StatelessWidget {
  const Indicators({
    super.key,
    required this.scrollindexNotifer,
    required this.imageUrl,
  });

  final ValueNotifier scrollindexNotifer;
  final List<String> imageUrl;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSmoothIndicator(
          activeIndex: scrollindexNotifer.value,
          onDotClicked: (index) {
            scrollindexNotifer.value = index;
          },
          count: imageUrl.length,
          effect: const ScaleEffect(
            activeDotColor: Colors.black,
            activePaintStyle: PaintingStyle.stroke,
            dotColor: Colors.black,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }
}

class ScrollableImages extends StatelessWidget {
  const ScrollableImages({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: Image.asset(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
