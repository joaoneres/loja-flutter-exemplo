import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/tiles/order_tile.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!UserModel.of(context).isLoggedIn()) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Colors.deepOrangeAccent,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text('Entre para ver seus pedidos!',
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
    } else {
      String userUid = UserModel.of(context).user.user.uid;
      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(userUid).collection('orders').get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map((document) => OrderTile(document.id)).toList().reversed.toList(),
            );
          }
        },
      );
    }

    return Container(
      
    );
  }
}