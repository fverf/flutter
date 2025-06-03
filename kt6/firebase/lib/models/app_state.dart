import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_service.dart';

class AppData extends ChangeNotifier {
  final AuthService _auth;
  bool _authenticated = false;
  User? _user;

  AppData(this._auth) {
    _initialize();
  }

  bool get isAuthenticated => _authenticated;
  User? get currentUser => _user;

  Future<void> _initialize() async {
    _authenticated = await _auth.checkAuthStatus();
    if (_authenticated) {
      _user = FirebaseAuth.instance.currentUser;
    }
    notifyListeners();
  }

  Future<void> createAccount(String email, String password) async {
    try {
      _user = await _auth.createAccount(email, password);
      _authenticated = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      _user = await _auth.signIn(email, password);
      _authenticated = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _authenticated = false;
      _user = null;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}