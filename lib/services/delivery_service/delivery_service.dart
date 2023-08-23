import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hrx_store/core/Model/address.dart';
import 'package:hrx_store/services/address_service/address_service.dart';

class DeliveryService {
  static Stream getAddress() async* {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(AddressService.userID)
        .collection('address')
        .get();
    final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
    yield docs;
  }

  static List<Address> convertToAddresssList(List<DocumentSnapshot> documents) {
    return documents.map((snapshot) {
      return Address.fromJson(snapshot.data() as Map<String, dynamic>);
    }).toList();
  }
}
