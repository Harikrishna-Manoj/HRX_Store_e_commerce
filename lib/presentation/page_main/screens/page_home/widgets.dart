import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_add_deabitcard/screen_add_card.dart';
import 'package:hrx_store/presentation/page_categories/screen_categories.dart';
import 'package:hrx_store/presentation/page_main/screens/page_profile/screen_profile.dart';
import 'package:hrx_store/presentation/page_product_detail/screem_product_detail.dart';
import 'package:hrx_store/presentation/page_view_all_product/screen_view_all_product.dart';
import 'package:hrx_store/presentation/page_wishlist/screen_wishlist.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../core/Model/product.dart';
import '../../../../core/constant.dart';
import '../../../../services/search_service/search_service.dart';
import '../../../../services/wishlist_service/wishlist_service.dart';
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
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const ScreenViewAllProduct(),
                      type: PageTransitionType.fade));
            },
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

    return StreamBuilder(
        stream: SeacrchService.getProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went worng'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!;
          List<Product> productList =
              SeacrchService.convertToProductsList(documents);

          return GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              clipBehavior: Clip.none,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              childAspectRatio: 1 / 1.45,
              children: List.generate(
                  productList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                // print(productList[index].id);
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: ScreenProductDetails(
                                            id: productList[index].id!),
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
                                              productList[index].imageurl!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        FavouriteButton(
                                          id: productList[index].id!,
                                          amount: productList[index]
                                              .price!
                                              .toString(),
                                          name: productList[index].name,
                                          imageurl:
                                              productList[index].imageurl!,
                                          category:
                                              productList[index].category!,
                                        ),
                                      ]),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 5),
                                        child: TextScroll(
                                          productList[index].name,
                                          mode: TextScrollMode.endless,
                                          velocity: const Velocity(
                                              pixelsPerSecond: Offset(30, 0)),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 5),
                                        child: Text(
                                          "Size : ${productList[index].size!}",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 5),
                                        child: Text(
                                          'Rate : ₹${productList[index].price}',
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
                      )));
        });
  }
}

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    super.key,
    required this.id,
    required this.imageurl,
    required this.amount,
    required this.name,
    required this.category,
  });

  final String id;
  final String imageurl;
  final String amount;
  final String name;
  final String category;
  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  ValueNotifier<bool> wishlistIconChangeNotifer = ValueNotifier<bool>(false);
  checkingWishlistStatus(String productId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser!.email;
    final wishlistSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(productId)
        .get();

    if (wishlistSnapshot.exists) {
      wishlistIconChangeNotifer.value = true;
    } else {
      wishlistIconChangeNotifer.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    checkingWishlistStatus(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: wishlistIconChangeNotifer,
        builder: (context, value, child) {
          return Positioned(
            left: 110,
            child: IconButton(
                onPressed: () {
                  checkingWishlistStatus(widget.id);
                  if (wishlistIconChangeNotifer.value == false) {
                    WishlistService.addToWishlist(
                        amount: widget.amount,
                        productId: widget.id,
                        category: widget.category,
                        image: widget.imageurl,
                        productName: widget.name,
                        context: context);
                  } else {
                    WishlistService.reomveFromWishlist(
                        productId: widget.id, context: context);
                  }
                },
                icon: wishlistIconChangeNotifer.value == true
                    ? const Icon(
                        Icons.favorite_outlined,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      )),
          );
        });
  }
}

class TransparentDrawer extends StatelessWidget {
  const TransparentDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          ProfilePhoto(
            image: user!.photoURL,
            name: user.displayName,
            email: user.email,
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

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
    required this.image,
    required this.name,
    required this.email,
  });
  final String? image;
  final String? name;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: const ScreenProfile(), type: PageTransitionType.fade));
      },
      child: Column(
        children: [
          kHeight20,
          image != null
              ? CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    image!,
                  ))
              : SizedBox(
                  height: 140,
                  width: 140,
                  child: Image.asset(
                    'asset/images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
          TextScroll(
              fadedBorder: true,
              fadeBorderSide: FadeBorderSide.both,
              fadedBorderWidth: .045,
              mode: TextScrollMode.endless,
              velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
              name ?? 'Name',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          TextScroll(
              fadedBorder: true,
              fadeBorderSide: FadeBorderSide.both,
              fadedBorderWidth: .045,
              mode: TextScrollMode.endless,
              velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
              email ?? "Email",
              style: const TextStyle(color: Colors.grey))
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
    // if (imageUrl.length > 3) {
    //   imageUrl.removeRange(2, imageUrl.length - 1);
    // }
    print(imageUrl.length);
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
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

// class FavouriteButton extends StatefulWidget {
//   const FavouriteButton({
//     super.key,
//     required this.productId,
//   });
//   final String productId;

//   @override
//   State<FavouriteButton> createState() => _FavouriteButtonState();
// }

// bool isAddedtoWishlist = false;
// final FirebaseAuth auth = FirebaseAuth.instance;
// final User? user = auth.currentUser;
// final userId = user!.email;
// final CollectionReference userCollection = FirebaseFirestore.instance
//     .collection('users')
//     .doc(userId)
//     .collection('wishlist');
// ValueNotifier<bool> wishlistIconChangeNotifer = ValueNotifier<bool>(false);

// class _FavouriteButtonState extends State<FavouriteButton> {
//   checkingWishlistStatus(String productId) async {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     final userId = currentUser!.email;
//     final wishlistSnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .collection('wishlist')
//         .doc(productId)
//         .get();

//     if (wishlistSnapshot.exists) {
//       wishlistIconChangeNotifer.value = true;
//     } else {
//       wishlistIconChangeNotifer.value = false;
//     }
//   }

//   @override
//   void initState() {
//     checkingWishlistStatus(widget.productId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: 5,
//       right: 5,
//       child: ValueListenableBuilder(
//           valueListenable: wishlistIconChangeNotifer,
//           builder: (context, value, child) {
//             return IconButton(
//               icon: wishlistIconChangeNotifer.value == true
//                   ? const Icon(
//                       Icons.favorite_outlined,
//                     )
//                   : const Icon(Icons.favorite_outline),
//               onPressed: () async {
//                 QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(userId)
//                     .collection('wishlist')
//                     .where('product', isEqualTo: widget.productId)
//                     .get();
//                 if (querySnapshot.docs.isEmpty) {
//                   final CollectionReference userCollection = FirebaseFirestore
//                       .instance
//                       .collection('users')
//                       .doc(userId)
//                       .collection('wishlist');
//                   await userCollection
//                       .doc(widget.productId)
//                       .set({'product': widget.productId});
//                   wishlistIconChangeNotifer.value = true;
//                 } else {
//                   wishlistIconChangeNotifer.value = false;
//                   await userCollection.doc(widget.productId).delete();
//                 }
//               },
//             );
//           }),
//     );
//   }
// }
class CurrentPosters extends StatefulWidget {
  const CurrentPosters({
    super.key,
    required this.posterimageUrl,
    required this.scrollIndexNotifier,
  });

  final List<String> posterimageUrl;
  final ValueNotifier<int> scrollIndexNotifier;

  @override
  State<CurrentPosters> createState() => _CurrentPostersState();
}

// List<String> ids = [];
String? id;

class _CurrentPostersState extends State<CurrentPosters> {
  getId() {
    FirebaseFirestore.instance.collection('poster').get().then(
      (QuerySnapshot querySnapshot) {
        // if (id.isNotEmpty) {
        //   id.removeLast();
        //   // print(id);
        //   // return;
        // }
        for (var doc in querySnapshot.docs) {
          // var orderData = doc.data();

          setState(() {
            id = doc.get('id');
          });
        }

        // print(id);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance.collection('poster').doc(id).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const SizedBox();
          }
          if (snapshot.hasData) {
            if (widget.posterimageUrl.isNotEmpty) {
              widget.posterimageUrl
                  .removeRange(0, widget.posterimageUrl.length);
            }
            for (String image in snapshot.data!['posterurl']) {
              widget.posterimageUrl.add(image);
            }
            // print('snapshot hasdata');
            return ValueListenableBuilder(
                valueListenable: widget.scrollIndexNotifier,
                builder: (context, value, child) {
                  return CarouselSlider.builder(
                      itemCount: widget.posterimageUrl.length,
                      itemBuilder: (context, index, realIndex) {
                        return ScrollableImages(
                          imageUrl: widget
                              .posterimageUrl[widget.scrollIndexNotifier.value],
                        );
                      },
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          widget.scrollIndexNotifier.value = index;
                        },
                      ));
                });
          }
          return const SizedBox();
          // print(posterId);
        });
  }
}
