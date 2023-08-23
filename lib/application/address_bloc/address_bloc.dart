import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hrx_store/core/Model/address.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(const AddressInitial()) {
    final userID = FirebaseAuth.instance.currentUser!.email;
    final addressRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('address');
    on<GetAllAddress>((event, emit) async {
      List<Address> addressList = [];
      int index = 0;
      final address = await addressRef.get();
      List<DocumentSnapshot> docList = address.docs;
      for (var document in docList) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        Address address = Address.fromJson(data);
        addressList.add(address);
      }
      final querySnapshot = await addressRef.get();
      final document = querySnapshot.docs;
      for (var i = 0; i < document.length; i++) {
        final boolValue = document[i]['isDefault'];

        if (boolValue == true) {
          index = i;
        }
      }

      emit(AddressState(addressList: addressList, index: index));
    });
    on<UpdateIndex>((event, emit) async {
      addressRef.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          if (doc.id == event.addressId) {
            doc.reference.update({'isDefault': true});
          } else {
            doc.reference.update({'isDefault': false});
          }
        }
      });
      add(GetAllAddress());
    });
  }
}
