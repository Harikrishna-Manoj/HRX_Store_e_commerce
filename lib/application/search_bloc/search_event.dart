part of 'search_bloc.dart';

@immutable
class SearchEvent {}

class GetAllProducts extends SearchEvent {}

class SearchProduct extends SearchEvent {
  final String text;

  SearchProduct({required this.text});
}
