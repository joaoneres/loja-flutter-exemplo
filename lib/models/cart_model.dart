import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja/datas/cart_product.dart';
import 'package:loja/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];
  String couponCode;
  int discountPercentage = 0;

  CartModel(this.user) {
    if(this.user.isLoggedIn()) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  bool isLoading = false;

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    FirebaseFirestore.instance.collection('users').doc(user.user.user.uid).collection('cart').add(cartProduct.toMap()).then((document) {
      cartProduct.cartId = document.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance.collection('users').doc(user.user.user.uid).collection('cart').doc(cartProduct.cartId).delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  void increaseProductQuantity(CartProduct cartProduct) {
    cartProduct.quantity++;
    FirebaseFirestore.instance.collection('users').doc(user.user.user.uid).collection('cart').doc(cartProduct.cartId).update(cartProduct.toMap());

    notifyListeners();
  }

  void decreaseProductQuantity(CartProduct cartProduct) {
    cartProduct.quantity--;
    FirebaseFirestore.instance.collection('users').doc(user.user.user.uid).collection('cart').doc(cartProduct.cartId).update(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user.user.user.uid).collection('cart').get();
    products = query.docs.map((document) => CartProduct.fromDocument(document)).toList();
    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice() {
    double price = 0.0;
    for(CartProduct cartProduct in products) {
      if(cartProduct.productData != null) {
        price += cartProduct.quantity * cartProduct.productData.price;
      }
    }

    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage/100;
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if(products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double discountValue = getDiscount();

    DocumentReference reference = await FirebaseFirestore.instance.collection('orders').add({
      'clientId': user.user.user.uid,
      'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
      'productsPrice': productsPrice,
      'discountValue': discountValue,
      'totalPrice': productsPrice - discountValue,
      'status': 1,
    });

    await FirebaseFirestore.instance.collection('users').doc(user.user.user.uid).collection('orders').doc(reference.id).set({
      'orderId': reference.id,
    });

    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user.user.user.uid).collection('cart').get();
    
    for(DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }

    products.clear();
    discountPercentage = 0;
    couponCode = null;
    isLoading = false;
    notifyListeners();

    return reference.id;
  }
}