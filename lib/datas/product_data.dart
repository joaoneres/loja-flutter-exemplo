
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category, id, title, description;
  double price;
  List images, sizes;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.data()['title'];
    description = snapshot.data()['description'];
    price = snapshot.data()['price'] + 0.0;
    images = snapshot.data()['images'];
    sizes = snapshot.data()['sizes'];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
    };
  }
}