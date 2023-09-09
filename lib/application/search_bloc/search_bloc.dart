import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/core/Model/product.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../services/search_service/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchInitial()) {
    on<GetAllProducts>((event, emit) async {
      emit(const SearchState(searchList: [], isLoading: true));
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
      List<Product> productList = SeacrchService.convertToProductsList(docs);
      emit(SearchState(searchList: productList, isLoading: false));
    });
    on<SearchProduct>((event, emit) async {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
      List<Product> productList = SeacrchService.convertToProductsList(docs);
      List<Product> searchList = productList.where((element) {
        if (element.name.toString().toLowerCase().contains(
                event.text.toLowerCase().replaceAll(RegExp(r"\s+"), "")) ||
            element.category.toString().toLowerCase().contains(
                event.text.toLowerCase().replaceAll(RegExp(r"\s+"), ""))) {
          return true;
        }
        return false;
      }).toList();
      emit(SearchState(searchList: searchList, isLoading: false));
    });
  }
}
