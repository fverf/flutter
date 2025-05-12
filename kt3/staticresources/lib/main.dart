import 'package:flutter/material.dart';

void main() => runApp(const StaticResourcesApp());

class StaticResourcesApp extends StatelessWidget {
  const StaticResourcesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Статичные ресурсы',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CoralPixels',
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontFamily: 'MochiyPopOne', fontSize: 24),
          bodyLarge: TextStyle(fontSize: 18),
        ),
      ),
      home: const ResourcesScreen(),
    );
  }
}

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  final List<String> _images = const [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ресурсы',
          style: TextStyle(fontFamily: 'MochiyPopOne'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Изображения:',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: _images.length,
                itemBuilder: (context, index) => Image.asset(_images[index]),
                separatorBuilder: (context, index) => const SizedBox(height: 20),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Etot text use CoralPixels',
              style: TextStyle(fontFamily: 'CoralPixels', fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
