import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_product_detail/widgets.dart';

// ignore: must_be_immutable
class ScreenProductDetails extends StatelessWidget {
  ScreenProductDetails({super.key});

  ValueNotifier scrollIndexNotifer = ValueNotifier(0);
  ValueNotifier sizeIndexNotifer = ValueNotifier(0);
  final imageUrl = [
    'asset/images/scroll1.jpeg',
    'asset/images/scroll2.jpeg',
    'asset/images/scroll3.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: ListView(
          children: [
            Stack(
              children: [
                Stack(
                  children: [
                    ValueListenableBuilder(
                        valueListenable: scrollIndexNotifer,
                        builder: (context, value, child) {
                          return CarouselSlider.builder(
                              itemCount: imageUrl.length,
                              itemBuilder: (context, index, realIndex) {
                                final urlImage =
                                    imageUrl[scrollIndexNotifer.value];
                                return ScrollableImages(urlImage: urlImage);
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
                    Positioned(
                      bottom: 100,
                      left: size.width / 2.4,
                      right: size.width / 2.4,
                      child: ValueListenableBuilder(
                          valueListenable: scrollIndexNotifer,
                          builder: (context, index, _) {
                            return Indicators(
                                scrollIndexNotifer: scrollIndexNotifer,
                                imageUrl: imageUrl);
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.trolley,
                                  size: 15,
                                )),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      right: 8,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline_outlined,
                              size: 16,
                            )),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: size.height * 0.44),
                    Container(
                      height: size.height * .45,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            kHeight30,
                            kHeight10,
                            const ProductDetailsText(
                                textColor: Colors.black,
                                text: 'Roller Rabit',
                                textSize: 20,
                                boldness: FontWeight.bold),
                            ProductDetailsText(
                              textColor: Colors.grey[700]!,
                              text: 'Dress',
                            ),
                            kHeight10,
                            const ProductDetailsText(
                                textColor: Colors.grey,
                                text: 'Total Price',
                                textSize: 10,
                                boldness: FontWeight.bold),
                            const ProductDetailsText(
                                textColor: Colors.black,
                                text: 'Rs. 199',
                                textSize: 20,
                                boldness: FontWeight.bold),
                            kHeight20,
                            const ProductDetailsText(
                                textColor: Colors.black,
                                text: 'Size',
                                textSize: 18,
                                boldness: FontWeight.bold),
                            const SizeSelection(),
                            const ProductDetailsText(
                                textColor: Colors.black,
                                text: 'Description',
                                textSize: 18,
                                boldness: FontWeight.bold),
                            const Text(
                                'jhsdgkjfdhgkdkgjbdskjghds/klbga;iufgdakjgdkjgbkfdjagfkfdjghgjskjgbkjghkjshg')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      )),
      floatingActionButton: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 20,
          ),
          SmallActionButtons(
              colr: Colors.white,
              string: 'Add to cart',
              icon: Icons.trolley,
              iconcolr: Colors.black,
              stringColor: Colors.black),
          SmallActionButtons(
            colr: Colors.black,
            string: 'Buy now',
            stringColor: Colors.white,
            iconcolr: Colors.white,
            icon: Icons.delivery_dining_outlined,
          )
        ],
      ),
    );
  }
}
