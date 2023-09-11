import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrx_store/core/Model/address.dart';
import 'package:hrx_store/main.dart';

import '../../presentation/page_address/screen_address.dart';

class AddressService {
  static final userID = FirebaseAuth.instance.currentUser!.email;
  static final addressRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('address');
  static void addAddress(Address address, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );
    // print('adress added${address.id.toString()}');
    await addressRef.doc(address.id).set(address.toJson());
    // print(address.id);
    addressRef.doc(address.id).update({'isDefault': true});
    navigatorKey.currentState!.pop();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              // ignore: prefer_const_constructors
              const ScreenAddress(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
    // ignore: use_build_context_synchronously
    Fluttertoast.showToast(msg: 'Address added');
  }

  static Future<List<Address>> displayAddress() async {
    List<Address> addressList = [];
    final address = await addressRef.get();
    List<DocumentSnapshot> docList = address.docs;
    for (var document in docList) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      Address address = Address.fromJson(data);
      addressList.add(address);
    }
    return addressList;
  }

  static updateDefalultValue(String addresId) async {
    addressRef.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc.id == addresId) {
          doc.reference.update({'isDefault': true});
        } else {
          doc.reference.update({'isDefault': false});
        }
      }
    });
  }

  static void updateAddress(Address address, BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      )),
    );
    // print('adress added${address.id.toString()}');
    await addressRef.doc(address.id).update(address.toJson());
    // print(address.id);
    addressRef.doc(address.id).update({'isDefault': true});
    navigatorKey.currentState!.pop();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              // ignore: prefer_const_constructors
              const ScreenAddress(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
    // ignore: use_build_context_synchronously
    Fluttertoast.showToast(msg: 'Address updated');
  }

  static deleteAddress(String id, BuildContext context) async {
    await addressRef.doc(id).delete();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              // ignore: prefer_const_constructors
              const ScreenAddress(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ));
    // ignore: use_build_context_synchronously
    Fluttertoast.showToast(msg: 'Address removed');
  }
}
