import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> userData = {
    'name': 'Не указано',
    'email': 'Не указано',
    'phone': 'Не указано',
    'address': 'Не указано',
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = {
        'name': prefs.getString('name') ?? 'Не указано',
        'email': prefs.getString('email') ?? 'Не указано',
        'phone': prefs.getString('phone') ?? 'Не указано',
        'address': prefs.getString('address') ?? 'Не указано',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя: ${userData['name']}', style: const TextStyle(fontSize: 16)),
            const Divider(),
            Text('Email: ${userData['email']}', style: const TextStyle(fontSize: 16)),
            const Divider(),
            Text('Телефон: ${userData['phone']}', style: const TextStyle(fontSize: 16)),
            const Divider(),
            Text('Адрес: ${userData['address']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/edit');
                  _loadUserData();
                },
                child: const Text('Редактировать'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    if (mounted) Navigator.pushReplacementNamed(context, '/auth');
  }
}