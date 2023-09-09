import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/cart_bloc/cart_bloc_bloc.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_main/screens/page_cart/widgets.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<CartBlocBloc>(context).add(GetAllCartProduct());
    });
    ValueNotifier<bool> cartPageRebuildNotifer = ValueNotifier(true);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        key: scaffoldKey,
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Column(
                children: [
                  kHeight10,
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          'My Cart',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.6,
                    child: ValueListenableBuilder(
                        valueListenable: cartPageRebuildNotifer,
                        builder: (context, value, child) {
                          cartPageRebuildNotifer.value = true;
                          return BlocBuilder<CartBlocBloc, CartBlocState>(
                              builder: (context, state) {
                            return state.isLoading == true
                                ? CartShimmer(size: size)
                                : state.cartProductList.isNotEmpty
                                    ? ListView.separated(
                                        itemBuilder: (context, index) {
                                          return SlideAction(
                                              cartPageRebuildNotifer:
                                                  cartPageRebuildNotifer,
                                              index: index.toString(),
                                              id: state
                                                  .cartProductList[index].id!,
                                              name: state
                                                  .cartProductList[index].name,
                                              productSize: state
                                                  .cartProductList[index].size!,
                                              price: state
                                                  .cartProductList[index].price
                                                  .toString(),
                                              image: state
                                                  .cartProductList[index]
                                                  .imageurl!);
                                        },
                                        separatorBuilder: (context, index) =>
                                            kHeight10,
                                        itemCount: state.cartProductList.length)
                                    : const Center(
                                        child: Text('Cart is empty'),
                                      );
                          });
                        }),
                  ),
                  kHeight30,
                  const TotalAmountWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const CartProceedButton(),
    );
  }
}
