import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/search_bloc/search_bloc.dart';

import 'package:hrx_store/presentation/page_search/widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:text_scroll/text_scroll.dart';

import '../page_product_detail/screem_product_detail.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SearchBloc>(context).add(GetAllProducts());
    });
    Size size = MediaQuery.sizeOf(context);

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
            BlocProvider.of<SearchBloc>(context)
                .add(SearchProduct(text: value));
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
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return state.searchList.isNotEmpty
                      ? Column(
                          children: List.generate(
                            state.searchList.length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: ScreenProductDetails(
                                                  id: state
                                                      .searchList[index].id!),
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
                                                  state.searchList[index]
                                                      .imageurl!,
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
                                                    state
                                                        .searchList[index].name,
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
                                                  state.searchList[index]
                                                      .category!,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                ),
                                                Text(
                                                  "₹ ${state.searchList[index].price!}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[600]),
                                                ),
                                              ],
                                            ),
                                            FavouriteButton(
                                                id: state.searchList[index].id!,
                                                imageurl: state
                                                    .searchList[index]
                                                    .imageurl!,
                                                amount: state
                                                    .searchList[index].price
                                                    .toString(),
                                                name: state
                                                    .searchList[index].name,
                                                category: state
                                                    .searchList[index]
                                                    .category!)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: size.height,
                          width: size.width,
                          child: const Center(
                            child: Text('No produts'),
                          ),
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
