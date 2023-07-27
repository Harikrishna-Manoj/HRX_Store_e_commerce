import 'package:carousel_slider/carousel_slider.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constant.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier indexNotifer = ValueNotifier(0);
    final imageUrl = [
      'asset/images/scroll1.jpeg',
      'asset/images/scroll2.jpeg',
      'asset/images/scroll3.jpeg',
    ];
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        ValueListenableBuilder(
            valueListenable: indexNotifer,
            builder: (context, value, child) {
              return CarouselSlider.builder(
                  itemCount: imageUrl.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = imageUrl[indexNotifer.value];
                    return ScrollableImages(urlImage: urlImage);
                  },
                  options: CarouselOptions(
                    aspectRatio: 3 / 4,
                    viewportFraction: 1,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      indexNotifer.value = index;
                    },
                  ));
            }),
        Positioned(
          bottom: 70,
          left: size.width / 2.5,
          right: size.width / 2.5,
          child: ValueListenableBuilder(
              valueListenable: indexNotifer,
              builder: (context, index, _) {
                return Indicators(
                    scrollIndexNotifer: indexNotifer, imageUrl: imageUrl);
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_circle_left_rounded,
                  size: largeFont,
                  color: Colors.black,
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.trolley,
                      size: 15,
                    )),
              ),
            )
          ],
        ),
        Positioned(
            bottom: 100,
            right: 8,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_outline_outlined,
                    size: 15,
                  )),
            ))
      ],
    );
  }
}

class Indicators extends StatelessWidget {
  const Indicators({
    super.key,
    required this.scrollIndexNotifer,
    required this.imageUrl,
  });

  final ValueNotifier scrollIndexNotifer;
  final List<String> imageUrl;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: scrollIndexNotifer.value,
      onDotClicked: (index) {
        scrollIndexNotifer.value = index;
      },
      count: imageUrl.length,
      effect: const ScaleEffect(
        activePaintStyle: PaintingStyle.stroke,
        activeDotColor: Colors.white,
        spacing: 15,
        dotColor: Colors.white,
        dotHeight: 9,
        dotWidth: 9,
        scale: 1.8,
      ),
    );
  }
}

class ScrollableImages extends StatelessWidget {
  const ScrollableImages({
    super.key,
    required this.urlImage,
  });

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }
}

class SmallActionButtons extends StatelessWidget {
  const SmallActionButtons(
      {super.key,
      required this.colr,
      required this.string,
      required this.stringColor,
      required this.icon,
      required this.iconcolr});

  final Color colr;
  final String string;
  final Color stringColor;
  final IconData icon;
  final Color iconcolr;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: colr,
      ),
      height: 50,
      width: 150,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            color: iconcolr,
          ),
          Text(
            string,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: stringColor),
          ),
        ],
      )),
    );
  }
}

class SizeSelection extends StatelessWidget {
  const SizeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      width: 50,
      height: 50,
      enableShape: true,
      spacing: 5,
      elevation: 0,
      customShape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30)),
      unSelectedColor: Colors.transparent,
      buttonLables: const [
        'S',
        'M',
        'L',
        'XL',
        'XXL',
      ],
      buttonValues: const [
        "Small",
        "Medium",
        "Large",
        "Extra Large",
        "Double EXtra Large",
      ],
      buttonTextStyle: const ButtonTextStyle(
        textStyle: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
      radioButtonValue: (value) {},
      selectedColor: Colors.black,
    );
  }
}

class ProductDetailsText extends StatelessWidget {
  const ProductDetailsText({
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
