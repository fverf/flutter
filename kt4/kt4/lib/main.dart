import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('counterBox');
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Счетчик',
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  late Box counterBox;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    counterBox = Hive.box('counterBox');
    counter = counterBox.get('counter', defaultValue: 0);
  }

  void incrementCounter() {
    setState(() {
      counter++;
      counterBox.put('counter', counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Счетчик')),
      body: Center(
        child: Text(
          'Нажали: $counter',
          style: const TextStyle(fontSize: 28),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
