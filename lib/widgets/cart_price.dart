import 'package:flutter/material.dart';
import 'package:loja/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;
  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {
            double price = model.getProductsPrice();
            double discount = model.getDiscount();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Resumo do Pedido',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Subtotal'),
                    Text('R\$ ${price.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Desconto'),
                    Text('R\$ ${discount.toStringAsFixed(2)}'),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total', 
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text('R\$ ${(price - discount).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                RaisedButton(
                  child: Text('Finalizar Pedido',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: buy,
                  color: Colors.deepOrangeAccent,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}