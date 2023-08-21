import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hrx_store/core/Model/product.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../services/search_service/search_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetAllProduct>((event, emit) async {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      final List<DocumentSnapshot> documents = querySnapshot.docs.toList();
      List<Product> productList =
          SeacrchService.convertToProductsList(documents);
      emit(HomeState(productList: productList));
    });
  }
}
