part of 'viewall_bloc.dart';

@immutable
class ViewallState {
  final List<Product> productList;

  const ViewallState({required this.productList});
}

final class ViewallInitial extends ViewallState {
  const ViewallInitial({super.productList = const []});
}
