import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:hrx_store/presentation/comman_widgets/common_widgets.dart';
import 'package:hrx_store/presentation/page_search/widget.dart';
import 'package:hrx_store/services/search_service/search_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:text_scroll/text_scroll.dart';

import '../page_product_detail/screem_product_detail.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ValueNotifier<String> searchNotifier = ValueNotifier<String>('');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_circle_left_sharp,
              size: 35,
            )),
        automaticallyImplyLeading: false,
        title: CupertinoSearchTextField(
          autofocus: true,
          onChanged: (value) {
            searchNotifier.value = value;
          },
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: searchNotifier,
                builder: (context, value, child) {
                  return StreamBuilder(
                    stream: SeacrchService.getProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return showSnackbar('Something went wrong', context);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> documents = snapshot.data!;
                        List<Product> productList =
                            SeacrchService.convertToProductsList(documents);
                        List<Product> searchList = productList
                            .where((element) => element.name
                                .toString()
                                .toLowerCase()
                                .contains(value
                                    .toLowerCase()
                                    .replaceAll(RegExp(r"\s+"), "")))
                            .toList();

                        return Column(
                          children: List.generate(
                            searchList.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // print(searchList[index].id);
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: ScreenProductDetails(
                                                  id: searchList[index].id!),
                                              type: PageTransitionType.fade));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 5,
                                      child: Container(
                                        width: size.width,
                                        height: size.height * 0.13,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 4, right: 15),
                                              height: size.height * 0.12,
                                              width: size.width * .23,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          13)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: Image.network(
                                                  searchList[index].imageurl!,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.45,
                                                  child: TextScroll(
                                                    searchList[index].name,
                                                    mode:
                                                        TextScrollMode.endless,
                                                    velocity: const Velocity(
                                                        pixelsPerSecond:
                                                            Offset(30, 0)),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Text(
                                                  searchList[index].category!,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                ),
                                                Text(
                                                  "₹ ${searchList[index].price!}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                ),
                                              ],
                                            ),
                                            FavouriteButton(
                                                id: searchList[index].id!,
                                                imageurl:
                                                    searchList[index].imageurl!,
                                                amount: searchList[index]
                                                    .price
                                                    .toString(),
                                                name: searchList[index].name,
                                                category:
                                                    searchList[index].category!)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const Text('');
                    },
                  );
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
