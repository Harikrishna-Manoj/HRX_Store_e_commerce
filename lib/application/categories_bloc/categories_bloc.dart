import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrx_store/core/Model/product.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../services/search_service/search_service.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(const CategoriesInitial()) {
    on<GetAllCategoryProduct>((event, emit) async {
      List<Product> shoes = [];
      List<Product> clothes = [];
      List<Product> bags = [];
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
      List<Product> productList = SeacrchService.convertToProductsList(docs);
      for (var product in productList) {
        if (product.category == 'Shoes') {
          shoes.add(product);
        } else if (product.category == 'Cloths') {
          clothes.add(product);
        } else if (product.category == 'Bags') {
          bags.add(product);
        }
      }
      emit(CategoriesState(clothes: clothes, bags: bags, shoes: shoes));
    });
  }
}
