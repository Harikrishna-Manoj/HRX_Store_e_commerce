import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import '../../core/Model/product.dart';
import '../../services/search_service/search_service.dart';

part 'viewall_event.dart';
part 'viewall_state.dart';

class ViewallBloc extends Bloc<ViewallEvent, ViewallState> {
  ViewallBloc() : super(const ViewallInitial()) {
    on<ViewallEvent>((event, emit) async {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      final List<DocumentSnapshot> documents = querySnapshot.docs.toList();
      List<Product> productList =
          SeacrchService.convertToProductsList(documents);
      emit(ViewallState(productList: productList));
    });
  }
}
