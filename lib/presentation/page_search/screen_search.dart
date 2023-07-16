import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/presentation/page_search/widgets.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CupertinoSearchTextField(
                    autofocus: true,
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([const GridProducts()]))
          ],
        ),
      )),
    );
  }
}
