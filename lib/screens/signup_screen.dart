import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Registre-se'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          FlatButton(
            child: Text('Entrar',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {   
          if(model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }    
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Nome Completo',
                  ),
                  keyboardType: TextInputType.name,
                  validator: (text) {
                    if(text.isEmpty) return 'Nome inválido!';
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'E-mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if(text.isEmpty || !text.contains('@')) return 'E-mail inválido!';
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                  ),
                  obscureText: true,
                  validator: (text) {
                    if(text.isEmpty || text.length < 6) return 'Senha inválida!';
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Endereço',
                  ),
                  validator: (text) {
                    if(text.isEmpty) return 'Endereço inválido!';
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        'name': _nameController.text,
                        'email': _emailController.text,
                        'address': _addressController.text,
                      };

                      model.signUp(userData: userData, password: _passwordController.text, onSuccess: _onSuccess, onFail: _onFail);
                    }
                  },
                )
              ],
            ),
          );
      }),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Você foi registrado com sucesso!',
        ),
        backgroundColor: Colors.deepOrangeAccent,
        duration: Duration(seconds: 2),
      )
    );

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Um erro ocorreu. Por favor, tente novamente.',
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}