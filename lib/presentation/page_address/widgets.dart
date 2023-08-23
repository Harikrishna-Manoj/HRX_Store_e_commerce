import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/application/address_bloc/address_bloc.dart';
import 'package:hrx_store/core/Model/address.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_address/screen_add_edit_address.dart';
import 'package:hrx_store/services/address_service/address_service.dart';
import 'package:page_transition/page_transition.dart';
import 'package:text_scroll/text_scroll.dart';

// ignore: must_be_immutable
class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    this.isThisAddPage,
    required this.homeName,
    required this.cityName,
    required this.pinCode,
    required this.state,
    required this.phoneNumber,
    required this.name,
    required this.id,
    required this.selectedAddressNotifier,
    required this.index,
    required this.address,
    required this.addressType,
  });
  final bool? isThisAddPage;
  final String addressType;
  final String homeName;
  final String name;
  final String cityName;
  final String pinCode;
  final String state;
  final String phoneNumber;
  final String id;
  final ValueNotifier selectedAddressNotifier;
  final int index;
  final List<Address> address;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Container(
          width: size.width,
          height: size.height * 0.18,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: size.width * 0.60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight15,
                    Row(
                      children: [
                        TextScroll(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                addressType,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    kHeight15,
                    Text('''$homeName,$cityName,
$state - $pinCode'''),
                    kHeight15,
                    Text(phoneNumber)
                  ],
                ),
              ),
              PopupMenuButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: ScreenAddEditAddress(
                                isThisAddPage: isThisAddPage!,
                                cityName: cityName,
                                homeName: homeName,
                                addresType: addressType,
                                id: id,
                                name: name,
                                phoneNumber: phoneNumber,
                                pinCode: pinCode,
                                state: state),
                            type: PageTransitionType.fade));
                  } else if (value == 2) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete confirmation',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          TextButton(
                              onPressed: () async {
                                AddressService.deleteAddress(id, context);
                              },
                              child: const Text('Delete',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)))
                        ],
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                      value: 1,
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      )),
                  const PopupMenuItem(
                      value: 2,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ))
                ],
              ),
              StatefulBuilder(builder: (context, setState) {
                return ValueListenableBuilder(
                  valueListenable: selectedAddressNotifier,
                  builder: (context, selectedAddressIndex, child) => Radio(
                    fillColor:
                        const MaterialStatePropertyAll<Color>(Colors.black),
                    value: selectedAddressIndex == index,
                    groupValue: true,
                    onChanged: (value) {
                      setState(() {
                        selectedAddressIndex = index;
                        selectedAddressNotifier.value = index;
                      });
                      BlocProvider.of<AddressBloc>(context).add(
                          UpdateIndex(addressId: address[index].id.toString()));
                    },
                  ),
                );
              }),
            ],
          )),
    );
  }
}

// ignore: must_be_immutable
class AddressTextField extends StatelessWidget {
  const AddressTextField({
    super.key,
    required this.controller,
    this.hiniText,
    required this.title,
    required this.keyboardType,
  });
  final TextEditingController controller;
  final String? hiniText;
  final String title;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
            cursorColor: Colors.black,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: title,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              contentPadding: const EdgeInsets.all(0),
              hintText: hiniText,
              hintStyle: const TextStyle(color: Colors.grey),
            )),
      ],
    );
  }
}
