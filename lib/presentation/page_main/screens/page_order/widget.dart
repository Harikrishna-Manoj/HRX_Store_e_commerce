import 'package:flutter/material.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard({
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
                  color: Colors.black, borderRadius: BorderRadius.circular(13)),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Roller Rabit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Quantity: ${1}',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Size : L',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  'Colour: White',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Do you want to cancel ?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Don't cancel",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Canel order',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)))
                    ],
                  ),
                );
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
