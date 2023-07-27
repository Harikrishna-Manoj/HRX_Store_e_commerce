import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/address.dart';
import 'package:hrx_store/core/constant.dart';
import 'package:hrx_store/presentation/page_address/screen_address.dart';
import 'package:hrx_store/presentation/page_address/widgets.dart';
import 'package:hrx_store/services/address_service/address_service.dart';
import 'package:page_transition/page_transition.dart';

class ScreenAddEditAddress extends StatelessWidget {
  const ScreenAddEditAddress({
    super.key,
    required this.isThisAddPage,
    this.homeName,
    this.name,
    this.cityName,
    this.pinCode,
    this.state,
    this.phoneNumber,
    this.id,
    this.addresType,
  });
  final bool isThisAddPage;
  final String? addresType;
  final String? homeName;
  final String? name;
  final String? cityName;
  final String? pinCode;
  final String? state;
  final String? phoneNumber;
  final String? id;

  @override
  Widget build(BuildContext context) {
    List<String> states = [
      "States",
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttar Pradesh",
      "Uttarakhand",
      "West Bengal",
    ];
    List<String> addressType = [
      'Address type',
      'Home',
      'Work space',
      'Apartment'
    ];
    final nameController = isThisAddPage
        ? TextEditingController()
        : TextEditingController(text: name);
    final phoneController = isThisAddPage
        ? TextEditingController()
        : TextEditingController(text: phoneNumber);
    final pinController = isThisAddPage
        ? TextEditingController()
        : TextEditingController(text: pinCode);
    final cityController = isThisAddPage
        ? TextEditingController()
        : TextEditingController(text: cityName);
    final houseNoController = isThisAddPage
        ? TextEditingController()
        : TextEditingController(text: homeName);

    String dropDownStateValue = isThisAddPage ? states.first : state!;
    String dropDownAddressTypeValue =
        isThisAddPage ? addressType.first : addresType!;
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const ScreenAddress(),
                        type: PageTransitionType.leftToRight));
              },
              icon: const Icon(
                Icons.arrow_circle_left,
                size: 35,
              )),
          title: Text(
            isThisAddPage ? 'Add address' : 'Edit address',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  kHeight10,
                  AddressTextField(
                      controller: nameController,
                      title: 'Name',
                      keyboardType: TextInputType.name),
                  kHeight30,
                  AddressTextField(
                      controller: phoneController,
                      title: 'Phone number',
                      keyboardType: TextInputType.phone),
                  kHeight30,
                  AddressTextField(
                      controller: pinController,
                      title: 'Pin code',
                      keyboardType: TextInputType.number),
                  kHeight30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButton<String>(
                            value: dropDownAddressTypeValue,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            borderRadius: BorderRadius.circular(15),
                            elevation: 8,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                            disabledHint: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropDownAddressTypeValue = value!;
                              });
                            },
                            items: addressType
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButton<String>(
                            value: dropDownStateValue,
                            icon:
                                const Icon(Icons.keyboard_arrow_down_outlined),
                            borderRadius: BorderRadius.circular(15),
                            elevation: 8,
                            alignment: Alignment.center,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                            disabledHint: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropDownStateValue = value!;
                              });
                            },
                            items: states
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                  kHeight30,
                  AddressTextField(
                      controller: cityController,
                      title: 'City, Street',
                      keyboardType: TextInputType.streetAddress),
                  kHeight30,
                  AddressTextField(
                      controller: houseNoController,
                      title: 'House no., Building name',
                      keyboardType: TextInputType.streetAddress),
                ],
              ),
            ),
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(
            isThisAddPage ? Icons.add : Icons.edit,
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          onPressed: () async {
            isThisAddPage
                ? AddressService.addAddress(
                    Address(
                        id: FirebaseFirestore.instance
                            .collection('users')
                            .doc(AddressService.userID)
                            .collection('address')
                            .doc()
                            .id,
                        name: nameController.text,
                        phoneNumber: int.parse(phoneController.text),
                        pinCode: int.parse(pinController.text),
                        addressType: dropDownAddressTypeValue,
                        state: dropDownStateValue,
                        cityOrStreet: cityController.text,
                        houseNoorName: houseNoController.text),
                    context)
                : AddressService.updateAddress(
                    Address(
                        id: id,
                        name: nameController.text,
                        phoneNumber: int.parse(phoneController.text),
                        pinCode: int.parse(pinController.text),
                        addressType: dropDownAddressTypeValue,
                        state: dropDownStateValue,
                        cityOrStreet: cityController.text,
                        houseNoorName: houseNoController.text),
                    context);
          },
          label: Text(isThisAddPage ? 'Add address' : 'Update address',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white)),
        ));
  }
}
