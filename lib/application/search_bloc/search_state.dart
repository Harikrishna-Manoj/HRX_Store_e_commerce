part of 'search_bloc.dart';

@immutable
class SearchState {
  final List<Product> searchList;
  const SearchState({required this.searchList});
}

final class SearchInitial extends SearchState {
  const SearchInitial({super.searchList = const []});
}
