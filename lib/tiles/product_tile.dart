import 'package:flutter/material.dart';
import 'package:loja/datas/product_data.dart';
import 'package:loja/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;
  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductScreen(product),
        ));
      },
      child: Card(
        child: type == 'grid' ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                product.images[0], 
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}', 
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ) : Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(product.images[0], 
                height: 220.0,  
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}', 
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}