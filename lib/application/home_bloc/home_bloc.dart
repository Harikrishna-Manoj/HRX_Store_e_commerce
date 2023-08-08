import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hrx_store/core/Model/product.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial([], [])) {
    on<GetAllProduct>((event, emit) async {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('product').get();
      final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
    });
  }
}
