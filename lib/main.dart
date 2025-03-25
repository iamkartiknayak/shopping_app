import 'package:flutter/material.dart';

import 'package:shopping_app/features/catalogue/presentation/catalogue_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade300),
      ),
      // darkTheme: ThemeData.dark(),
      home: CataloguePage(),
    );
  }
}
