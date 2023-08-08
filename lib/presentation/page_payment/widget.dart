import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../page_add_deabitcard/screen_add_card.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.value,
    required this.imageUrl,
  });

  final String value;
  final String imageUrl;
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
          height: size.height * 0.06,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 4, right: 15),
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(imageUrl),
                ),
              ),
              Text(
                value,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
  }
}

class AddCard extends StatelessWidget {
  const AddCard({
    super.key,
    required this.colr,
    required this.value,
  });
  final Color colr;
  final String value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: const ScreenAddCard(),
                type: PageTransitionType.rightToLeft));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Container(
            width: size.width,
            height: size.height * 0.06,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 15),
                  height: size.height * 0.05,
                  width: size.height * 0.05,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      color: colr,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Icon(Icons.add),
                ),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            )),
      ),
    );
  }
}

class FloatingText extends StatelessWidget {
  const FloatingText({
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
