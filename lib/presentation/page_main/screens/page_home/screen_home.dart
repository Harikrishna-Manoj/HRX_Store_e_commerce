import 'package:flutter/material.dart';

import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_main/screens/page_home/widgets.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollIndexNotifier = ValueNotifier(0);

  List<String> posterimageUrl = [];
  late String posterId;
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
                    CurrentPosters(
                        posterimageUrl: posterimageUrl,
                        scrollIndexNotifier: scrollIndexNotifier),
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
