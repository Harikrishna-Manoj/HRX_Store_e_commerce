import 'package:flutter/material.dart';

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

class AddressDetails extends StatelessWidget {
  const AddressDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height * .3,
      width: size.width,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Street: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "City:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "State:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Phone number:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Country:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
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
        InkWell(onTap: () {}, child: Icon(editIcon))
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
