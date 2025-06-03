import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_data.dart';
import '../auth/auth_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Основное меню'),
        actions: [
          if (appData.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                await appData.logout();
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                  );
                }
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (appData.isAuthenticated)
              Column(
                children: [
                  Text(
                    'Привет, ${appData.currentUser?.email ?? 'друг'}!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  const Text('Доступны все функции'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showFeatureMessage(context, 'Премиум доступен'),
                    child: const Text('Премиум'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  const Text('Гость'),
                  const SizedBox(height: 20),
                  const Text('Ограниченный функционал'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showFeatureMessage(context, 'Базовая функция'),
                    child: const Text('Базовая'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AuthScreen()),
                    ),
                    child: const Text('Авторизация'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showFeatureMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}