import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmação de Pedido'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.remove_shopping_cart,
              size: 80.0,
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text('Seu pedido foi realizado\ncom sucesso!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Text('Código do pedido:\n{$orderId}',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}