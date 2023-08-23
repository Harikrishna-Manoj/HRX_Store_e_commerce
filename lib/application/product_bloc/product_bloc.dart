import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductInitial()) {
    on<GetImages>((event, emit) async {
      final imageQuery = await FirebaseFirestore.instance
          .collection('product')
          .doc(event.id)
          .get();
      List<String> imageUrl = [];
      imageUrl.add(imageQuery['imageurl']);
      for (var element in imageQuery['multiimage']) {
        imageUrl.add(element);
      }
      emit(ProductState(
          image: imageQuery['imageurl'],
          price: imageQuery['price'],
          category: imageQuery['category'],
          name: imageQuery['name'],
          imageUrl: imageUrl));
    });
  }
}
