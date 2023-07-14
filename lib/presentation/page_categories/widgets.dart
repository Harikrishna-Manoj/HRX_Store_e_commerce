import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.imageUrl,
    required this.heading,
  });
  final String imageUrl;
  final String heading;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Card(
          child: Container(
            width: size.width,
            height: size.height * 0.12,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          top: (size.height * 0.12) / 3,
          left: (size.width) / 3,
          child: Text(
            heading,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
