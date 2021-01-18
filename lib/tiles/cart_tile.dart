import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/datas/cart_product.dart';
import 'package:loja/datas/product_data.dart';
import 'package:loja/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct; 
  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      CartModel.of(context).updatePrices();
      
      return Row(
        children: <Widget>[
          Container(
            width: 160.0,
            child: Image.network(
              cartProduct.productData.images[0], 
              fit: BoxFit.cover
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(cartProduct.productData.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0,
                    ),
                  ),
                  Text('Tamanho: ${cartProduct.productSize}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                  ),
                  Text('Preço: R\$ ${cartProduct.productData.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: cartProduct.quantity > 1 ? () {
                          CartModel.of(context).decreaseProductQuantity(cartProduct);
                        } : null,
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          CartModel.of(context).increaseProductQuantity(cartProduct);
                        },
                      ),
                      FlatButton(
                        child: Text('Remover'),
                        textColor: Colors.deepOrangeAccent[100],
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      ),
                    ],
                  ),
                ],
              ),  
            ),
          ),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('products').doc(cartProduct.productCategory).collection('items').doc(cartProduct.productId).get(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            cartProduct.productData = ProductData.fromDocument(snapshot.data);
            return _buildContent();
          } else {
            return Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
              height: 70.0,
            );
          }
        },
      ),
    );
  }
}