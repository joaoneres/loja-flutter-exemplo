import 'package:flutter/material.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Entrar'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          FlatButton(
            child: Text('Criar Conta',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => SignUpScreen(),
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
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      if(_emailController.text.trim().isEmpty) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Informe um e-mail para enviarmos seu código de redefinição de senha.',
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          )
                        );
                      } else {
                        model.recoverPassword(_emailController.text.trim());
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'Confira seu e-mail!',
                            ),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          )
                        );
                      }
                    },
                    child: Text(
                      'Esqueci minha senha!',
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      model.signIn(email: _emailController.text, password: _passwordController.text, onSuccess: _onSuccess, onFail: _onFail);
                    }
                  },
                )
              ],
            ),
          );
        },

      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Falha ao entrar. Por favor, tente novamente.',
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}