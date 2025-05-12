import 'package:flutter/material.dart';

void main() => runApp(const StaticResourcesApp());

class StaticResourcesApp extends StatelessWidget {
  const StaticResourcesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Статичные ресурсы',
      debugShowCheckedModeBanner: false,
      theme: _buildAppTheme(),
      home: const ResourcesScreen(),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'CoralPixels',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(fontFamily: 'Mochiy Pop One'),
        bodyLarge: TextStyle(fontSize: 18),
      ),
    );
  }
}

class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  static const _images = [
    'assets/images/image1.jpg',
    'assets/images/image2.jpg',
    'assets/images/image3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: _ResourcesContent(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Ресурсы',
        style: TextStyle(fontFamily: 'Mochiy Pop One'),
      ),
    );
  }
}

class _ResourcesContent extends StatelessWidget {
  const _ResourcesContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Изображения:',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 20),
        const _ImageList(),
        const SizedBox(height: 20),
        const Text(
          'Etot text use CoralPixels',
          style: TextStyle(fontFamily: 'CoralPixels'),
        ),
      ],
    );
  }
}

class _ImageList extends StatelessWidget {
  const _ImageList();

  @override
  Widget build(BuildContext context) {
    final images = ResourcesScreen._images;

    return Expanded(
      child: ListView.separated(
        itemCount: images.length,
        itemBuilder: (context, index) => Image.asset(images[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}
