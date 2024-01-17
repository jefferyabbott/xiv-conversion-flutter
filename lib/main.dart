import 'package:flutter/material.dart';
import 'package:xiv_conversion/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XIV Conversion',
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}
