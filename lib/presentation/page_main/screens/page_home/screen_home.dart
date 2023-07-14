import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_main/screens/page_home/widgets.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollIndexNotifier = ValueNotifier(0);
  final posterimageUrl = [
    'asset/images/poster3.jpeg',
    'asset/images/poster2.jpg',
    'asset/images/poster1.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const TransparentDrawer(),
      body: SafeArea(
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    expandedHeight: size.height * 0.2,
                    flexibleSpace: FlexibleSpaceBar(
                      background: ListView(
                        children: [
                          kHeight10,
                          SlideIconAndDecarationText(scaffoldKey: _scaffoldKey)
                        ],
                      ),
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    pinned: true,
                    centerTitle: false,
                    bottom: const PreferredSize(
                        // ignore: sort_child_properties_last
                        child: SizedBox(
                          height: 10,
                        ),
                        preferredSize: Size.fromHeight(-10)),
                    flexibleSpace: const SearchField(),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    kHeight10,
                    ValueListenableBuilder(
                        valueListenable: scrollIndexNotifier,
                        builder: (context, value, child) {
                          return CarouselSlider.builder(
                              itemCount: posterimageUrl.length,
                              itemBuilder: (context, index, realIndex) {
                                return ScrollableImages(
                                  imageUrl:
                                      posterimageUrl[scrollIndexNotifier.value],
                                );
                              },
                              options: CarouselOptions(
                                aspectRatio: 16 / 9,
                                viewportFraction: 1,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  scrollIndexNotifier.value = index;
                                },
                              ));
                        }),
                    kHeight10,
                    ValueListenableBuilder(
                        valueListenable: scrollIndexNotifier,
                        builder: (context, index, _) {
                          return Indicators(
                            scrollindexNotifer: scrollIndexNotifier,
                            imageUrl: posterimageUrl,
                          );
                        }),
                    kHeight10,
                    const ViewAllProduct(),
                    const GridProducts()
                  ]))
                ],
              ))),
    );
  }
}
