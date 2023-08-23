import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/address.dart';
import 'package:hrx_store/presentation/page_address/screen_address.dart';
import 'package:hrx_store/services/address_service/address_service.dart';
import 'package:hrx_store/services/delivery_service/delivery_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../core/Model/product.dart';
import '../../core/constant.dart';
import '../../services/cart_service/cart_service.dart';
import '../page_payment/screen_payment.dart';

// ignore: must_be_immutable
class CartProductCard extends StatelessWidget {
  const CartProductCard({
    super.key,
    required this.name,
    required this.productSize,
    required this.price,
    required this.image,
    required this.id,
    required this.index,
    required this.colour,
  });
  final String name;
  final String productSize;
  final String price;
  final String image;
  final String id;
  final String index;
  final String colour;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Card(
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
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: TextScroll(
                      name,
                      mode: TextScrollMode.endless,
                      velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Row(
                    children: [
                      Text('$colour |'),
                      Text('| Size: $productSize'),
                    ],
                  ),
                  kHeight10,
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(AddressService.userID)
                          .collection('cart')
                          .doc(id)
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        // print('rebuilded');
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const SizedBox
                              .shrink(); // Handle case where document doesn't exist anymore
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: size.width * 0.135,
                            width: size.width * 0.05,
                          );
                        }
                        return Row(
                          children: [
                            Text(
                              "₹ $price X ${snapshot.data['productcount']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        );
                      }),
                ],
              ),
            ],
          )),
    );
  }
}

class FromProductPageProductCard extends StatelessWidget {
  const FromProductPageProductCard({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('product')
              .doc(id)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ProductShimmer(size: size);
            }
            return Container(
                width: size.width,
                height: size.height * 0.13,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 15),
                      height: size.height * 0.12,
                      width: size.width * .23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: Image.network(
                          snapshot.data['imageurl'],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('${snapshot.data['color']} |'),
                            Text('| Size: ${snapshot.data['size']}'),
                          ],
                        ),
                        kHeight10,
                        Text(
                          '₹ ${snapshot.data['price']}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ));
          }),
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height * .13,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) => Shimmer(
          color: Colors.black,
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
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
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AddressService.userID)
            .collection('address')
            .snapshots(),
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: DeliveryService.getAddress(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                    color: Colors.black,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                          width: size.width,
                          height: size.height * 0.18,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  kHeight15,
                                  const TextScroll(
                                    '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  kHeight15,
                                  const Text(''''''),
                                  kHeight15,
                                  const Text('')
                                ],
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                            ],
                          )),
                    ),
                  );
                }
                List<DocumentSnapshot> documents = snapshot.data;
                List<Address> addresList =
                    DeliveryService.convertToAddresssList(documents);
                List<Address> selectedAddress = addresList
                    .where((element) => element.isDefault == true)
                    .toList();
                // print(selectedAddress);
                return SizedBox(
                  width: size.width,
                  height: size.height * 0.20,
                  child: ListView.builder(
                    itemCount: selectedAddress.length,
                    itemBuilder: (context, index) {
                      //   print(
                      //       '''${selectedAddress[index].houseNoorName}(H),${selectedAddress[index].cityOrStreet},
                      // ${selectedAddress[index].state} - ${selectedAddress[index].pinCode.toString()}''');
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                            width: size.width,
                            height: size.height * 0.18,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    kHeight15,
                                    Row(
                                      children: [
                                        TextScroll(
                                          selectedAddress[index].name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Container(
                                            height: 20,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text(
                                                selectedAddress[index]
                                                    .addressType,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    kHeight15,
                                    Text(
                                        '''${selectedAddress[index].houseNoorName}(H),${selectedAddress[index].cityOrStreet},
${selectedAddress[index].state} - ${selectedAddress[index].pinCode.toString()}'''),
                                    kHeight15,
                                    Text(
                                        '${selectedAddress[index].phoneNumber}')
                                  ],
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                );
              });
        });
  }
}

class SubTitles extends StatelessWidget {
  const SubTitles({super.key, required this.heading, this.editIcon});
  final String heading;
  final IconData? editIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        // InkWell(onTap: () {}, child: Icon(editIcon))
        IconButton(
            tooltip: 'Change Address',
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const ScreenAddress(),
                      type: PageTransitionType.fade));
            },
            icon: Icon(
              editIcon,
            ))
      ],
    );
  }
}

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    required this.textColor,
    required this.text,
    this.textSize,
    this.boldness,
  });
  final Color textColor;
  final String text;
  final double? textSize;
  final FontWeight? boldness;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: textSize, fontWeight: boldness, color: textColor),
        ),
      ],
    );
  }
}

class FromProductPageTotalAmount extends StatelessWidget {
  const FromProductPageTotalAmount({
    super.key,
    required this.id,
  });
  final String id;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product')
            .doc(id)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const TotalAmountShimmer();
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Amount'),
                  Text('₹ ${snapshot.data['price']}')
                ],
              ),
              kHeight10,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping fee'),
                  Text(
                    'Free',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              kHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total price'),
                  Text(
                    '₹ ${snapshot.data['price']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              )
            ],
          );
        });
  }
}

class TotalAmountShimmer extends StatelessWidget {
  const TotalAmountShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: [
          Shimmer(
            color: Colors.black,
            child: const SizedBox(
              width: double.infinity,
              height: 20,
            ),
          ),
          kHeight10,
          Shimmer(
            color: Colors.black,
            child: const SizedBox(
              width: double.infinity,
              height: 20,
            ),
          ),
          kHeight10,
          Shimmer(
            color: Colors.black,
            child: const SizedBox(
              width: double.infinity,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class CartProductShimmer extends StatelessWidget {
  const CartProductShimmer({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 72,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Shimmer(
          color: Colors.black,
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13)),
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
      ),
    );
  }
}

class FromCartPageTotalAmount extends StatelessWidget {
  const FromCartPageTotalAmount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AddressService.userID)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          // ignore: unused_local_variable
          int totalPrice = 0;
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const TotalAmountShimmer();
          }
          if (snapshot.hasData) {
            List<dynamic> productPrice = snapshot.data!.docs
                .map((doc) => doc.get('totalprice'))
                .toList();
            totalPrice = CartServices.updateTotalPrice(productPrice);
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text('Amount'), Text('₹ $totalPrice')],
              ),
              kHeight10,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping fee'),
                  Text(
                    'Free',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              kHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total price'),
                  Text(
                    '₹ $totalPrice',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              )
            ],
          );
        });
  }
}

class FromCartPageProductCard extends StatelessWidget {
  const FromCartPageProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      height: size.height * .3,
      child: FutureBuilder<QuerySnapshot>(
          future: CartServices.getProductId(),
          builder: (context, cartSnapshot) {
            if (cartSnapshot.hasData) {
              List<dynamic> productId = cartSnapshot.data!.docs
                  .map((doc) => doc.get('productid'))
                  .toList();
              // print(cartSnapshot.data);
              // print(productId);
              return FutureBuilder<QuerySnapshot>(
                  future:
                      FirebaseFirestore.instance.collection('product').get(),
                  builder: (context, productSnapshot) {
                    // print(productSnapshot.data);
                    if (productSnapshot.hasData) {
                      List<Product> productList = productSnapshot.data!.docs
                          .map((doc) => Product.fromJson(
                              doc.data() as Map<String, dynamic>))
                          .where((product) => productId.contains(product.id))
                          .toList();
                      // print(productList);
                      return productList.isNotEmpty
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                return CartProductCard(
                                    index: index.toString(),
                                    colour: productList[index].color!,
                                    id: productList[index].id!,
                                    name: productList[index].name,
                                    productSize: productList[index].size!,
                                    price: productList[index].price.toString(),
                                    image: productList[index].imageurl!);
                              },
                              separatorBuilder: (context, index) => kHeight10,
                              itemCount: productList.length)
                          : const Center(
                              child: Text('No product'),
                            );
                    }
                    return CartProductShimmer(size: size);
                  });
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            );
          }),
    );
  }
}

class FromProductPageProceedButton extends StatelessWidget {
  const FromProductPageProceedButton({
    super.key,
    required this.id,
  });
  final String id;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product')
            .doc(id)
            .snapshots(),
        builder: (context, AsyncSnapshot productSnapshot) {
          if (productSnapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return Shimmer(
              color: Colors.black,
              child: const ProductPriceText(
                textColor: Colors.black,
                text: 'Price',
                boldness: FontWeight.bold,
                textSize: 20,
              ),
            );
          }
          return StreamBuilder(
              stream: DeliveryService.getAddress(),
              builder: (context, addresssnapshot) {
                if (addresssnapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (addresssnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Shimmer(
                      color: Colors.black,
                      child: FloatingActionButton.extended(
                          onPressed: () {},
                          backgroundColor: Colors.black,
                          label: const ProductPriceText(
                            textColor: Colors.white,
                            text: 'Proceed',
                            boldness: FontWeight.bold,
                            textSize: 20,
                          )));
                }
                List<DocumentSnapshot> documents = addresssnapshot.data;
                List<Address> addresList =
                    DeliveryService.convertToAddresssList(documents);
                List<Address> selectedAddress = addresList
                    .where((element) => element.isDefault == true)
                    .toList();
                return FloatingActionButton.extended(
                    onPressed: () {
                      // print(id);
                      // print(selectedAddress);
                      // print('${productSnapshot.data['price']}');
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ScreenPayment(
                                fromCart: false,
                                addressId: selectedAddress.first.id!,
                                toalValue:
                                    productSnapshot.data['price'].toString(),
                                productId: id,
                              ),
                              type: PageTransitionType.rightToLeft));
                    },
                    backgroundColor: Colors.black,
                    label: const ProductPriceText(
                      textColor: Colors.white,
                      text: 'Proceed',
                      boldness: FontWeight.bold,
                      textSize: 20,
                    ));
              });
        });
  }
}

class FromProductTotalAmountFloating extends StatelessWidget {
  const FromProductTotalAmountFloating({
    super.key,
    required this.id,
  });

  final String? id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('product')
            .doc(id)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer(
              color: Colors.black,
              child: const ProductPriceText(
                textColor: Colors.black,
                text: 'Price',
                boldness: FontWeight.bold,
                textSize: 20,
              ),
            );
          }
          return ProductPriceText(
            textColor: Colors.black,
            text: '₹ ${snapshot.data['price']}',
            boldness: FontWeight.bold,
            textSize: 20,
          );
        });
  }
}

class FromCartTotalAmountFloating extends StatelessWidget {
  const FromCartTotalAmountFloating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AddressService.userID)
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          // ignore: unused_local_variable
          int totalPrice = 0;
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Shimmer(
              color: Colors.black,
              child: const ProductPriceText(
                textColor: Colors.black,
                text: 'Price',
                boldness: FontWeight.bold,
                textSize: 20,
              ),
            );
          }
          if (snapshot.hasData) {
            List<dynamic> productPrice = snapshot.data!.docs
                .map((doc) => doc.get('totalprice'))
                .toList();
            totalPrice = CartServices.updateTotalPrice(productPrice);
          }
          return ProductPriceText(
            textColor: Colors.black,
            text: '₹ $totalPrice',
            boldness: FontWeight.bold,
            textSize: 20,
          );
        });
  }
}

class FromCartProceedButton extends StatelessWidget {
  const FromCartProceedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(AddressService.userID)
            .collection('cart')
            .snapshots(),
        builder: (context, AsyncSnapshot cartSnapshot) {
          int totalPrice = 0;
          if (cartSnapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          if (cartSnapshot.connectionState == ConnectionState.waiting) {
            return Shimmer(
              color: Colors.black,
              child: const ProductPriceText(
                textColor: Colors.black,
                text: 'Price',
                boldness: FontWeight.bold,
                textSize: 20,
              ),
            );
          }
          List<dynamic> productIdList = cartSnapshot.data!.docs
              .map((doc) => doc.get('productid'))
              .toList();
          List<dynamic> productPrice = cartSnapshot.data!.docs
              .map((doc) => doc.get('totalprice'))
              .toList();
          totalPrice = CartServices.updateTotalPrice(productPrice);
          return StreamBuilder(
              stream: DeliveryService.getAddress(),
              builder: (context, addresssnapshot) {
                if (addresssnapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }
                if (addresssnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Shimmer(
                      color: Colors.black,
                      child: FloatingActionButton.extended(
                          onPressed: () {},
                          backgroundColor: Colors.black,
                          label: const ProductPriceText(
                            textColor: Colors.white,
                            text: 'Proceed',
                            boldness: FontWeight.bold,
                            textSize: 20,
                          )));
                }
                List<DocumentSnapshot> documents = addresssnapshot.data;
                List<Address> addresList =
                    DeliveryService.convertToAddresssList(documents);
                List<Address> selectedAddress = addresList
                    .where((element) => element.isDefault == true)
                    .toList();
                return FloatingActionButton.extended(
                    onPressed: () {
                      // print(productIdList);
                      // print(selectedAddress.first.id);
                      // print(totalPrice.toString());
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ScreenPayment(
                                fromCart: true,
                                addressId: selectedAddress.first.id!,
                                toalValue: totalPrice.toString(),
                                productIdList: productIdList,
                              ),
                              type: PageTransitionType.rightToLeft));
                    },
                    backgroundColor: Colors.black,
                    label: const ProductPriceText(
                      textColor: Colors.white,
                      text: 'Proceed',
                      boldness: FontWeight.bold,
                      textSize: 20,
                    ));
              });
        });
  }
}
