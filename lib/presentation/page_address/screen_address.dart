import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hrx_store/core/Model/address.dart';
import 'package:hrx_store/presentation/page_address/screen_add_edit_address.dart';
import 'package:hrx_store/presentation/page_address/widgets.dart';
import 'package:hrx_store/services/address_service/address_service.dart';
import 'package:page_transition/page_transition.dart';

class ScreenAddress extends StatefulWidget {
  const ScreenAddress({super.key});

  @override
  State<ScreenAddress> createState() => _ScreenAddressState();
}

ValueNotifier<int> selectedAddressNotifier = ValueNotifier(0);

class _ScreenAddressState extends State<ScreenAddress> {
  List<Address> address = [];
  final addressRef = FirebaseFirestore.instance
      .collection('users')
      .doc(AddressService.userID)
      .collection('address');
  getAddress() async {
    address = await AddressService.displayAddress();
    setState(() {
      address = address;
    });
  }

  getRadioIndex() {
    addressRef.get().then((QuerySnapshot querySnapshot) {
      final doccument = querySnapshot.docs;
      for (var i = 0; i < doccument.length; i++) {
        final boolValue = doccument[i]['isDefault'];
        if (boolValue) {
          selectedAddressNotifier.value = i;
        } else {
          break;
        }
      }
    });
  }

  @override
  void initState() {
    getAddress();
    getRadioIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: address.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                  address.length,
                  (index) => AddressCard(
                    address: address,
                    index: index,
                    addressType: address[index].addressType,
                    selectedAddressNotifier: selectedAddressNotifier,
                    id: address[index].id!,
                    name: address[index].name,
                    cityName: address[index].cityOrStreet,
                    homeName: address[index].houseNoorName,
                    phoneNumber: address[index].phoneNumber.toString(),
                    state: address[index].state,
                    pinCode: address[index].pinCode.toString(),
                    isThisAddPage: isThisAddPage,
                  ),
                )))
              : const Center(
                  child: Text('Add address '),
                ),
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
