part of 'delivery_bloc.dart';

class DeliveryState {
  final List<Address> selectedAddress;

  const DeliveryState({required this.selectedAddress});
}

class DeliveryInitial extends DeliveryState {
  DeliveryInitial({super.selectedAddress = const []});
}
