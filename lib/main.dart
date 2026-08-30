import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EscolaApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A4A9E),
        ),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          filled: false,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
