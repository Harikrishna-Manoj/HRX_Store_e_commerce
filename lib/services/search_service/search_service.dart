import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hrx_store/core/Model/product.dart';

class SeacrchService {
  static Stream getProducts() async* {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('product').get();
    final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
    yield docs;
  }

  static List<Product> convertToProductsList(List<DocumentSnapshot> documents) {
    return documents.map((snapshot) {
      return Product.fromJson(snapshot.data() as Map<String, dynamic>);
    }).toList();
  }
}
