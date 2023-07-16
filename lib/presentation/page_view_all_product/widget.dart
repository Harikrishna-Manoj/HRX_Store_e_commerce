import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../page_product_detail/screem_product_detail.dart';

class AllGridProducts extends StatelessWidget {
  const AllGridProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final Stream<QuerySnapshot> userStream =
        FirebaseFirestore.instance.collection('product').snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: userStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              clipBehavior: Clip.none,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              childAspectRatio: 1 / 1.45,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ScreenProductDetails(),
                                  type: PageTransitionType.fade));
                        },
                        child: Card(
                          elevation: 3,
                          child: SizedBox(
                            width: size.width * 0.6,
                            height: size.height * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  Container(
                                    width: size.width * 0.45,
                                    height: size.width * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        data['imageurl'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 110,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.favorite_outline)))
                                ]),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 5),
                                  child: Text(
                                    data['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 5),
                                  child: Text(
                                    data['category'],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 5),
                                  child: Text(
                                    'Rate : ${data['price']}',
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
                );
              }).toList());
        });
  }
}
