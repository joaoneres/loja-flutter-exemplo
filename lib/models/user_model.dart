import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class UserModel extends Model {
  FirebaseAuth _auth =  FirebaseAuth.instance;
  UserCredential user;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  } 

  void signUp({@required Map<String, dynamic> userData, @required String password, @required VoidCallback onSuccess, @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

      _auth.createUserWithEmailAndPassword(email: userData['email'].toString().trim(), password: password).catchError((e) {
        onFail();
        isLoading = false;
        notifyListeners();
      }).then((userResponse) async {
        user = userResponse;
        await _saveUserData(userData);
        onSuccess();
        isLoading = false;
        notifyListeners();
      });
  }

  void signIn({@required String email, @required String password, @required VoidCallback onSuccess, @required VoidCallback onFail }) async {
    isLoading = true;
    notifyListeners();
    
    _auth.signInWithEmailAndPassword(email: email, password: password).then((userResponse) async {
      user = userResponse;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    })
    .catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    user = null;
    notifyListeners();
  }

  void recoverPassword(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return user != null;
  } 

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection('users').doc(user.user.uid).set(userData);
  }

  Future<Null> _loadCurrentUser() async {
    final User currentUser = _auth.currentUser;
    DocumentSnapshot documentUser = await FirebaseFirestore.instance.collection('users').doc(user.user.uid ?? currentUser.uid).get();
    userData = documentUser.data();
    notifyListeners();
  }
}