import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_delivery/screen_delivery.dart';
import 'package:hrx_store/presentation/page_main/screens/page_cart/screen_cart.dart';
import 'package:hrx_store/presentation/page_product_detail/widgets.dart';
import 'package:hrx_store/services/cart_service/cart_service.dart';
import 'package:hrx_store/services/wishlist_service/wishlist_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

// ignore: must_be_immutable
class ScreenProductDetails extends StatefulWidget {
  const ScreenProductDetails({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ScreenProductDetails> createState() => _ScreenProductDetailsState();
}

class _ScreenProductDetailsState extends State<ScreenProductDetails> {
  List<String> colorList = ['Black', 'Red', 'Blue'];
  List<Color> colorsOfBox = [Colors.grey, Colors.red, Colors.blue];
  List<String> sizeintList = ['6', '7', '8', '9', '10', '11'];
  List<String> sizeStringList = [
    'Small',
    'Medium',
    'Large',
  ];
  int choiceChipColorValue = 0;
  int choiceChipSizeValue = 0;

  ValueNotifier scrollIndexNotifer = ValueNotifier(0);
  ValueNotifier sizeIndexNotifer = ValueNotifier(0);
  ValueNotifier<bool> addCartIconChangeNotifer = ValueNotifier<bool>(false);
  ValueNotifier<bool> wishlistIconChangeNotifer = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    checkingTheProductInCart(widget.id);
    checkingWishlistStatus(widget.id);
  }

  checkingTheProductInCart(String productId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser!.email;
    final cartSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId)
        .get();

    if (cartSnapshot.exists) {
      addCartIconChangeNotifer.value = true;
    } else {
      addCartIconChangeNotifer.value = false;
    }
  }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('product')
                          .doc(widget.id)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Shimmer(
                            color: Colors.black,
                            child: SizedBox(
                              width: size.width,
                              height: size.height * .5,
                            ),
                          );
                        }
                        List<String> imageUrl = [];
                        imageUrl.add(snapshot.data['imageurl']);
                        for (var element in snapshot.data['multiimage']) {
                          imageUrl.add(element);
                        }
                        return Stack(
                          children: [
                            ValueListenableBuilder(
                                valueListenable: scrollIndexNotifer,
                                builder: (context, value, child) {
                                  return imageUrl.length == 1
                                      ? SizedBox(
                                          width: size.width,
                                          child: Image.network(
                                            imageUrl.first,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : CarouselSlider.builder(
                                          itemCount: imageUrl.length,
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            final urlImage = imageUrl[
                                                scrollIndexNotifer.value];
                                            return ScrollableImages(
                                                urlImage: urlImage);
                                          },
                                          options: CarouselOptions(
                                            height: size.height * .55,
                                            aspectRatio: 3 / 4,
                                            viewportFraction: 1,
                                            autoPlay: true,
                                            onPageChanged: (index, reason) {
                                              scrollIndexNotifer.value = index;
                                            },
                                          ));
                                }),
                            Column(
                              children: [
                                kHeight100,
                                kHeight100,
                                kHeight100,
                                kHeight20,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: scrollIndexNotifer,
                                      builder: (context, index, _) {
                                        return Indicators(
                                            scrollIndexNotifer:
                                                scrollIndexNotifer,
                                            imageUrl: imageUrl);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.black,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          size: 15,
                                          color: Colors.white,
                                        )),
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: addCartIconChangeNotifer,
                                      builder: (context, value, child) {
                                        return CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              addCartIconChangeNotifer.value ==
                                                      true
                                                  ? Colors.black
                                                  : Colors.white,
                                          child: IconButton(
                                              onPressed: () async {
                                                checkingTheProductInCart(
                                                    widget.id);
                                                if (addCartIconChangeNotifer
                                                        .value ==
                                                    false) {
                                                  // ignore: unrelated_type_equality_checks
                                                  if (await CartServices
                                                          .checkProductExistance(
                                                              productId:
                                                                  widget.id,
                                                              colour: colorList[
                                                                  choiceChipColorValue],
                                                              size: snapshot.data[
                                                                          'category'] ==
                                                                      'Shoes'
                                                                  ? sizeintList[
                                                                      choiceChipSizeValue]
                                                                  : sizeStringList[
                                                                      choiceChipSizeValue],
                                                              // totalValue: snapshot
                                                              //     .data['price'],
                                                              context:
                                                                  context) ==
                                                      true) {
                                                    // ignore: use_build_context_synchronously
                                                    await CartServices
                                                        .addToCart(
                                                      colour: colorList[
                                                          choiceChipColorValue],
                                                      context: context,
                                                      productId: widget.id,
                                                      size: snapshot.data[
                                                                  'category'] ==
                                                              'Shoes'
                                                          ? sizeintList[
                                                              choiceChipSizeValue]
                                                          : sizeStringList[
                                                              choiceChipSizeValue],
                                                      totalValue: snapshot
                                                          .data['price'],
                                                    );
                                                  }
                                                } else {
                                                  await CartServices
                                                      .reomveFromCart(
                                                          productId: widget.id,
                                                          context: context);
                                                }
                                              },
                                              icon: addCartIconChangeNotifer
                                                          .value ==
                                                      true
                                                  ? const Icon(
                                                      Icons.trolley,
                                                      color: Colors.white,
                                                      size: 15,
                                                    )
                                                  : const Icon(
                                                      Icons.trolley,
                                                      size: 15,
                                                    )),
                                        );
                                      })
                                ],
                              ),
                            ),
                            ValueListenableBuilder(
                                valueListenable: wishlistIconChangeNotifer,
                                builder: (context, value, child) {
                                  return Positioned(
                                    bottom: 150,
                                    right: 8,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor:
                                          wishlistIconChangeNotifer.value ==
                                                  true
                                              ? Colors.black
                                              : Colors.white,
                                      child: IconButton(
                                          onPressed: () {
                                            // print(snapshot.data['price']);
                                            // print(snapshot.data['category']);
                                            // print(snapshot.data['imageurl']);
                                            // print(snapshot.data['name']);
                                            // print(widget.id);

                                            checkingWishlistStatus(widget.id);
                                            if (wishlistIconChangeNotifer
                                                    .value ==
                                                false) {
                                              WishlistService.addToWishlist(
                                                  amount: snapshot.data['price']
                                                      .toString(),
                                                  category:
                                                      snapshot.data['category'],
                                                  image:
                                                      snapshot.data['imageurl'],
                                                  productName:
                                                      snapshot.data['name'],
                                                  productId: widget.id,
                                                  context: context);
                                            } else {
                                              WishlistService
                                                  .reomveFromWishlist(
                                                      productId: widget.id,
                                                      context: context);
                                            }
                                          },
                                          icon:
                                              wishlistIconChangeNotifer.value ==
                                                      true
                                                  ? const Icon(
                                                      Icons.favorite_outlined,
                                                      color: Colors.red,
                                                      size: 16,
                                                    )
                                                  : const Icon(
                                                      Icons.favorite_border,
                                                      size: 16,
                                                    )),
                                    ),
                                  );
                                }),
                          ],
                        );
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('product')
                          .doc(widget.id)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return DeatilShimmer(size: size);
                        }
                        return Column(
                          children: [
                            SizedBox(height: size.height * 0.44),
                            Container(
                              height: size.height * .65,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    kHeight30,
                                    kHeight10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ProductDetailsText(
                                            textColor: Colors.black,
                                            text: snapshot.data['name'],
                                            textSize: 20,
                                            boldness: FontWeight.bold),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Column(
                                            children: [
                                              const ProductDetailsText(
                                                  textColor: Colors.black,
                                                  text: 'Total Price',
                                                  textSize: 10,
                                                  boldness: FontWeight.bold),
                                              ProductDetailsText(
                                                  textColor: Colors.black,
                                                  text:
                                                      "₹ ${snapshot.data['price'].toString()}",
                                                  textSize: 20,
                                                  boldness: FontWeight.bold),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    ProductDetailsText(
                                      textColor: Colors.grey[700]!,
                                      text: snapshot.data['category'],
                                    ),
                                    kHeight10,

                                    const ProductDetailsText(
                                        textColor: Colors.black,
                                        text: 'Colour',
                                        textSize: 18,
                                        boldness: FontWeight.bold),
                                    //color choice chip
                                    StatefulBuilder(
                                      builder:
                                          (BuildContext context, setState) {
                                        return Wrap(
                                          // direction: Axis.vertical,
                                          spacing: 5.0,
                                          children: List<Widget>.generate(
                                            colorList.length,
                                            (int index) {
                                              return ChoiceChip(
                                                disabledColor: Colors.black,
                                                selectedColor:
                                                    colorsOfBox[index],
                                                label: Text(
                                                  colorList[index],
                                                  style: colorsOfBox[index] ==
                                                          Colors.black
                                                      ? const TextStyle(
                                                          color: Colors.black)
                                                      : const TextStyle(
                                                          color: Colors.black),
                                                ),
                                                selected:
                                                    choiceChipColorValue ==
                                                        index,
                                                onSelected: (bool selected) {
                                                  setState(
                                                    () {
                                                      choiceChipColorValue =
                                                          (selected
                                                              ? index
                                                              : index);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          ).toList(),
                                        );
                                      },
                                    ),
                                    const ProductDetailsText(
                                        textColor: Colors.black,
                                        text: 'Size',
                                        textSize: 18,
                                        boldness: FontWeight.bold),
                                    snapshot.data['category'] == 'Shoes'
                                        ? StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Wrap(
                                                spacing: 5.0,
                                                children: List<Widget>.generate(
                                                  sizeintList.length,
                                                  (int index) {
                                                    return ChoiceChip(
                                                      disabledColor:
                                                          Colors.white,
                                                      selectedColor:
                                                          Colors.grey,
                                                      label: Text(
                                                        sizeintList[index]
                                                            .toString(),
                                                      ),
                                                      selected:
                                                          choiceChipSizeValue ==
                                                              index,
                                                      onSelected:
                                                          (bool selected) {
                                                        setState(
                                                          () {
                                                            choiceChipSizeValue =
                                                                (selected
                                                                    ? index
                                                                    : index);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ).toList(),
                                              );
                                            },
                                          )
                                        : StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              return Wrap(
                                                spacing: 5.0,
                                                children: List<Widget>.generate(
                                                  sizeStringList.length,
                                                  (int index) {
                                                    return ChoiceChip(
                                                      disabledColor:
                                                          Colors.white,
                                                      selectedColor:
                                                          Colors.grey,
                                                      label: Text(
                                                        sizeStringList[index],
                                                      ),
                                                      selected:
                                                          choiceChipSizeValue ==
                                                              index,
                                                      onSelected:
                                                          (bool selected) {
                                                        setState(
                                                          () {
                                                            choiceChipSizeValue =
                                                                (selected
                                                                    ? index
                                                                    : index);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ).toList(),
                                              );
                                            },
                                          ),
                                    const ProductDetailsText(
                                        textColor: Colors.black,
                                        text: 'Description',
                                        textSize: 18,
                                        boldness: FontWeight.bold),
                                    kHeight10,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            snapshot.data['description'],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      )),
      floatingActionButton: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('product')
              .doc(widget.id)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return ValueListenableBuilder(
                valueListenable: addCartIconChangeNotifer,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      addCartIconChangeNotifer.value == true
                          ? InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        child: const ScreenCart(),
                                        type: PageTransitionType.fade));
                              },
                              child: const SmallActionButtons(
                                  colr: Colors.white,
                                  string: 'Go to cart',
                                  icon: Icons.trolley,
                                  iconcolr: Colors.black,
                                  stringColor: Colors.black),
                            )
                          : InkWell(
                              onTap: () async {
                                checkingTheProductInCart(widget.id);
                                if (addCartIconChangeNotifer.value == false) {
                                  // ignore: unrelated_type_equality_checks
                                  if (await CartServices.checkProductExistance(
                                          productId: widget.id,
                                          colour:
                                              colorList[choiceChipColorValue],
                                          size: snapshot.data['category'] ==
                                                  'Shoes'
                                              ? sizeintList[choiceChipSizeValue]
                                              : sizeStringList[
                                                  choiceChipSizeValue],
                                          // totalValue: snapshot.data['price'],
                                          context: context) ==
                                      true) {
                                    // ignore: use_build_context_synchronously
                                    await CartServices.addToCart(
                                      colour: colorList[choiceChipColorValue],
                                      context: context,
                                      productId: widget.id,
                                      size: sizeintList[choiceChipSizeValue],
                                      totalValue: snapshot.data['price'],
                                    );
                                  }
                                } else {
                                  await CartServices.reomveFromCart(
                                      productId: widget.id, context: context);
                                }
                              },
                              child: const SmallActionButtons(
                                  colr: Colors.white,
                                  string: 'Add to cart',
                                  icon: Icons.trolley,
                                  iconcolr: Colors.black,
                                  stringColor: Colors.black),
                            ),
                      InkWell(
                        onTap: () async {
                          if (await CartServices.checkProductExistance(
                                  productId: widget.id,
                                  colour: colorList[choiceChipColorValue],
                                  size: snapshot.data['category'] == 'Shoes'
                                      ? sizeintList[choiceChipSizeValue]
                                      : sizeStringList[choiceChipSizeValue],
                                  // totalValue: snapshot.data['price'],
                                  context: context) ==
                              true) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                PageTransition(
                                    child: ScreenDelivery(
                                        fromCart: false, id: widget.id),
                                    type: PageTransitionType.rightToLeft));
                          }
                        },
                        child: const SmallActionButtons(
                          colr: Colors.black,
                          string: 'Buy now',
                          stringColor: Colors.white,
                          iconcolr: Colors.white,
                          icon: Icons.delivery_dining_outlined,
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}
