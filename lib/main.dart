// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'navigation_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const NavigationPage(),                        // Sets the starting page
    );
  }
}

