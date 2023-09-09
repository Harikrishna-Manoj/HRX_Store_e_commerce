part of 'search_bloc.dart';

@immutable
class SearchState {
  final List<Product> searchList;
  final bool isLoading;
  const SearchState({required this.searchList, required this.isLoading});
}

final class SearchInitial extends SearchState {
  const SearchInitial({super.searchList = const [], super.isLoading = false});
}
