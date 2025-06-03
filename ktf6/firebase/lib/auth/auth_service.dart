import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> createAccount(String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _updateAuthStatus(true);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _parseAuthError(e);
    } catch (e) {
      throw 'Ошибка регистрации';
    }
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _updateAuthStatus(true);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _parseAuthError(e);
    } catch (e) {
      throw 'Ошибка входа';
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _updateAuthStatus(false);
    } catch (e) {
      throw 'Ошибка выхода';
    }
  }

  Future<bool> checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStatus = prefs.getBool('userAuthenticated') ?? false;
    return savedStatus && _firebaseAuth.currentUser != null;
  }

  Future<void> _updateAuthStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userAuthenticated', status);
  }

  String _parseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use': return 'Email уже используется';
      case 'invalid-email': return 'Неверный email';
      case 'weak-password': return 'Слабый пароль';
      case 'user-not-found': return 'Пользователь не найден';
      case 'wrong-password': return 'Неверный пароль';
      case 'user-disabled': return 'Аккаунт заблокирован';
      default: return 'Ошибка: ${e.message}';
    }
  }
}