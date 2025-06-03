import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/user_authentication.dart';
import 'models/app_session.dart';
import 'auth/authentication_flow.dart';
import 'screens/primary_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ApplicationRoot());
}

class ApplicationRoot extends StatelessWidget {
  final UserAuthManager authManager = UserAuthManager();

  ApplicationRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AppSession(authManager),
      child: MaterialApp(
        title: 'Аутентификация',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
        ),
        home: FutureBuilder<bool>(
          future: authManager.checkCurrentSession(),
          builder: (ctx, authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return authSnapshot.data == true 
                ? const PrimaryScreen() 
                : const AuthenticationFlow();
          },
        ),
        routes: {
          '/auth': (ctx) => const AuthenticationFlow(),
          '/home': (ctx) => const PrimaryScreen(),
        },
      ),
    );
  }
}