import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/return_bloc/returns_bloc.dart';
import 'package:hrx_store/presentation/page_returned_product/widgets.dart';

import '../../core/constant.dart';

class ScreenReturnedProduct extends StatelessWidget {
  const ScreenReturnedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<ReturnsBloc>(context).add(GetAllReturnedProduct());
    });
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Returns',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left,
              size: 35,
            )),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child:
            BlocBuilder<ReturnsBloc, ReturnsState>(builder: (context, state) {
          return state.isLoading == true
              ? ReturnShimmer(size: size)
              : state.returnList.isNotEmpty
                  ? ListView.separated(
                      itemCount: state.returnList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ReturnedProductCard(
                            imageUrl: state.returnedProductList[0].imageurl!,
                            productName: state.returnedProductList[0].name,
                            productSize: state.returnedProductList[0].size!,
                            color: state.returnedProductList[0].color!,
                            productId: state.returnList[index].productId,
                            price:
                                state.returnedProductList[0].price.toString());
                      },
                      separatorBuilder: (context, index) => kHeight10,
                    )
                  : const Center(
                      child: Text('No returns'),
                    );
        }),
      ),
    );
  }
}
