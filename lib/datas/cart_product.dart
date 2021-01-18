import 'package:loja/datas/product_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct {
  String cartId, productCategory, productId, productSize;
  int quantity;

  ProductData productData;
  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot documentSnapshot) {
    cartId = documentSnapshot.id;
    productCategory = documentSnapshot.data()['productCategory'];
    productId = documentSnapshot.data()['productId'];
    quantity = documentSnapshot.data()['quantity'];
    productSize = documentSnapshot.data()['productSize'];
  }

  Map<String, dynamic> toMap() {
    return {
      'productCategory': productCategory,
      'productId': productId,
      'quantity': quantity,
      'size': productSize,
      'product': productData.toResumedMap(),
    };
  }
}