import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:loja/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepOrangeAccent,
            Colors.deepOrangeAccent[100],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0), 
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 120.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 10.0,
                      left: 0.0,
                      child: Text('ShoesOn\nStore', 
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, 'Início', pageController, 0),
              DrawerTile(Icons.list, 'Produtos', pageController, 1),
              DrawerTile(Icons.location_on, 'Lojas', pageController, 2),
              DrawerTile(Icons.playlist_add_check, 'Meus Pedidos', pageController, 3),
              Divider(),
              SizedBox(height: 20.0),
              ScopedModelDescendant<UserModel>(
                builder: (context, child, model) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(!model.isLoggedIn() ? 'Olá! Tudo bem? Caso possua uma\nconta, conecte-se para\nadquirir nossos produtos.' : 'Olá, ${model.userData['name']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(!model.isLoggedIn()) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                          } else {
                            model.signOut();
                          }
                        },
                        child: Text(!model.isLoggedIn() ? 'Entre ou cadastre-se' : 'Sair',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}