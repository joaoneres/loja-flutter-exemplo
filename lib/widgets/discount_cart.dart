import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/cart_model.dart';

class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text('Cupom de Desconto',
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite aqui seu cupom...',
              ),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance.collection('coupons').doc(text).get().then((documentSnapshot) {
                  if(documentSnapshot.data() != null) {
                    CartModel.of(context).setCoupon(documentSnapshot.id, documentSnapshot.data()['percent']);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Desconto de ${documentSnapshot.data()['percent']}% aplicado!'),
                      backgroundColor: Colors.deepOrangeAccent,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Cupom inválido!'),
                      backgroundColor: Colors.deepOrangeAccent,
                    ));
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}