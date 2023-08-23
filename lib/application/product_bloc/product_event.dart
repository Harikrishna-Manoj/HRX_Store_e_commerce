part of 'product_bloc.dart';

@immutable
class ProductEvent {}

class GetImages extends ProductEvent {
  final String id;

  GetImages({required this.id});
}
