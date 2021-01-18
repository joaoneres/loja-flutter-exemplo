import 'package:flutter/material.dart';
import 'package:loja/tabs/home_tab.dart';
import 'package:loja/tabs/orders_tab.dart';
import 'package:loja/tabs/products_tab.dart';
import 'package:loja/tabs/stores_tab.dart';
import 'package:loja/widgets/cart_buttom.dart';
import 'package:loja/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
            backgroundColor: Colors.deepOrangeAccent,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Lojas'),
            backgroundColor: Colors.deepOrangeAccent,
            centerTitle: true,
          ),
          body: StoresTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Meus Pedidos'),
            backgroundColor: Colors.deepOrangeAccent,
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}