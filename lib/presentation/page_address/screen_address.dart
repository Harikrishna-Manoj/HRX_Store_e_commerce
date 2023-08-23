import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/presentation/page_address/screen_add_edit_address.dart';
import 'package:hrx_store/presentation/page_address/widgets.dart';
import 'package:page_transition/page_transition.dart';

import '../../application/address_bloc/address_bloc.dart';

class ScreenAddress extends StatelessWidget {
  const ScreenAddress({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<AddressBloc>(context).add(GetAllAddress());
    });
    ValueNotifier<int> selectedAddressNotifier = ValueNotifier(0);

    bool isThisAddPage = false;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_circle_left_rounded,
              size: 35,
            )),
        centerTitle: true,
        title: const Text(
          'Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            selectedAddressNotifier.value = state.index;
            return SizedBox(
              height: size.height,
              width: size.width,
              child: state.addressList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                          children: List.generate(
                      state.addressList.length,
                      (index) => AddressCard(
                        address: state.addressList,
                        index: index,
                        addressType: state.addressList[index].addressType,
                        selectedAddressNotifier: selectedAddressNotifier,
                        id: state.addressList[index].id!,
                        name: state.addressList[index].name,
                        cityName: state.addressList[index].cityOrStreet,
                        homeName: state.addressList[index].houseNoorName,
                        phoneNumber:
                            state.addressList[index].phoneNumber.toString(),
                        state: state.addressList[index].state,
                        pinCode: state.addressList[index].pinCode.toString(),
                        isThisAddPage: isThisAddPage,
                      ),
                    )))
                  : const Center(
                      child: Text('Add address '),
                    ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const ScreenAddEditAddress(isThisAddPage: true),
                  type: PageTransitionType.fade));
        },
        label: const Text(
          'Add address',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
