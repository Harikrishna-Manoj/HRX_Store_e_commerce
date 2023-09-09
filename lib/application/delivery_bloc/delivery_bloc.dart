// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../core/Model/address.dart';
import '../../services/delivery_service/delivery_service.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryInitial()) {
    on<GetAddress>((event, emit) async {
      final userId = FirebaseAuth.instance.currentUser!.email;
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('address')
          .get();
      List<DocumentSnapshot> docs = querySnapshot.docs;
      List<Address> addresList = DeliveryService.convertToAddresssList(docs);
      List<Address> selectAddress =
          addresList.where((element) => element.isDefault == true).toList();
      emit(DeliveryState(selectedAddress: selectAddress));
    });
  }
}
