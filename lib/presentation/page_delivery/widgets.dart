import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_address/screen_address.dart';
import 'package:page_transition/page_transition.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../core/constant.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

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
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(13)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Roller Rabit',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text('Roller Rabit'),
                  kHeight10,
                  const Text(
                    '300',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          )),
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
          width: size.width,
          height: size.height * 0.18,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
                    'Harikrishna Manoj',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  kHeight15,
                  const Text('''Panachikal(H),Angamaly,
Kerala - 683576'''),
                  kHeight15,
                  const Text('9539440572')
                ],
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          )),
    );
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
