part of 'address_bloc.dart';

@immutable
class AddressState {
  final List<Address> addressList;
  final int index;
  const AddressState({required this.addressList, required this.index});
}

class AddressInitial extends AddressState {
  const AddressInitial({super.addressList = const [], super.index = 0});
}
