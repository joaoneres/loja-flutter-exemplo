import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja/datas/cart_product.dart';
import 'package:loja/datas/product_data.dart';
import 'package:loja/models/cart_model.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/cart_screen.dart';
import 'package:loja/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  _ProductScreenState(this.product);
  String selectedProductSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 3.0,
              dotSpacing: 10.0,
              dotBgColor: Colors.transparent,
              dotColor: Colors.deepOrangeAccent[100],
              autoplay: false,
              dotIncreasedColor: Colors.deepOrangeAccent,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Tamanhos Disponíveis',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  height: 32.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map((size) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedProductSize = size;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              width: 1.0,
                            ),
                            color: size == selectedProductSize ?  Colors.deepOrangeAccent : Colors.grey[300], 
                          ),
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text(size),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,                  
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: selectedProductSize != null ? () {
                      if(UserModel.of(context).isLoggedIn()) {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.productSize = selectedProductSize;
                        cartProduct.quantity = 1;
                        cartProduct.productId = product.id;
                        cartProduct.productCategory = product.category;
                        cartProduct.productData = product;
                        CartModel.of(context).addCartItem(cartProduct);

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CartScreen(),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      }
                    } : null,
                    child: Text(UserModel.of(context).isLoggedIn() ? 'Adicionar ao Carrinho' : 'Entre para Comprar', 
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Descrição do Produto',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}