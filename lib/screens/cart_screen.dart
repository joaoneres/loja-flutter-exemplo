import 'package:flutter/material.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/screens/order_screen.dart';
import 'package:loja/tiles/cart_tile.dart';
import 'package:loja/widgets/cart_price.dart';
import 'package:loja/widgets/discount_cart.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int productQuantity = model.products.length;
                return Text('${productQuantity ?? 0} ${productQuantity == 1 ? 'Item' : 'Itens'}');
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if(model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Colors.deepOrangeAccent,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('Entre para adicionar produtos!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                    },
                    child: Text('Entrar',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                ],
              ),
            );
          } else if(model.products == null || model.products.length == 0) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80.0,
                    color: Colors.deepOrangeAccent,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('Nenhum produto em seu carrinho!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map((product) {
                    return CartTile(product);
                  }).toList(),
                ),
                DiscountCart(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();

                  if(orderId != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrderScreen(orderId),
                    ));
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}