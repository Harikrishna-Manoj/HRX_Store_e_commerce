import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/wishlist_bloc/wishlist_bloc.dart';
import 'package:hrx_store/presentation/page_wishlist/widgets.dart';

import '../../core/constant.dart';

class ScreenWishlist extends StatelessWidget {
  const ScreenWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<WishlistBloc>(context).add(GetAllWishedProducts());
    });
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Wishlist ♥',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left,
              size: 35,
            )),
      ),
      body: SafeArea(
          child: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.89,
                width: size.width,
                child: BlocBuilder<WishlistBloc, WishlistState>(
                  builder: (context, state) {
                    return state.isLoading == true
                        ? WishListShimmer(size: size)
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, right: 10),
                            child: state.wishList.isNotEmpty
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return WishlistProductCard(
                                        category:
                                            state.wishList[index].category!,
                                        id: state.wishList[index].id!,
                                        imageUrl:
                                            state.wishList[index].imageurl!,
                                        name: state.wishList[index].name,
                                        price: state.wishList[index].price!,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        kHeight10,
                                    itemCount: state.wishList.length)
                                : const Center(
                                    child: Text('No wished items'),
                                  ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
