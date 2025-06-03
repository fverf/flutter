import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailInput = TextEditingController();
  final _passInput = TextEditingController();
  bool _loginMode = true;
  bool _processing = false;
  String? _authError;

  @override
  void dispose() {
    _emailInput.dispose();
    _passInput.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _processing = true;
      _authError = null;
    });

    try {
      final appData = Provider.of<AppData>(context, listen: false);
      final email = _emailInput.text.trim();
      final password = _passInput.text.trim();

      _loginMode 
          ? await appData.signIn(email, password)
          : await appData.createAccount(email, password);
    } catch (e) {
      if (mounted) {
        setState(() => _authError = e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _processing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loginMode ? 'Авторизация' : 'Создать аккаунт'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _emailInput,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Введите email';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                      return 'Некорректный email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passInput,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Введите пароль';
                    if (val.length < 6) return 'Минимум 6 символов';
                    return null;
                  },
                ),
                if (_authError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _authError!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 24),
                _processing
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _authenticate,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(_loginMode ? 'Войти' : 'Создать'),
                      ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _loginMode = !_loginMode;
                      _authError = null;
                    });
                  },
                  child: Text(_loginMode
                      ? 'Нет аккаунта? Зарегистрироваться'
                      : 'Есть аккаунт? Войти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}