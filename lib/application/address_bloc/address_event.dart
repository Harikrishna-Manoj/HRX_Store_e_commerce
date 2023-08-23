part of 'address_bloc.dart';

@immutable
class AddressEvent {}

class GetAllAddress extends AddressEvent {}

class UpdateIndex extends AddressEvent {
  final String addressId;

  UpdateIndex({required this.addressId});
}
