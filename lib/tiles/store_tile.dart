import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreTile extends StatelessWidget {
  final DocumentSnapshot snapshot;
  StoreTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 150.0,
            child: Image.network(snapshot.data()['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data()['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(snapshot.data()['address'],
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  launch('https://www.google.com/maps/search/?api=1&query=${snapshot.data()['lat']},${snapshot.data()['long']}');
                },
                child: Text('Acessar no Google Maps'),
                padding: EdgeInsets.zero,
              ),
              FlatButton(
                onPressed: () {
                  launch('tel:${snapshot.data()['phone']}');
                },
                child: Text('Ligar'),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}