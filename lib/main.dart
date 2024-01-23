import 'package:communityconnect/pages/login_page.dart';
import 'package:communityconnect/pages/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Connect',
      home: const LoginPage(),
      routes: {
        "/login_page/": (context) => const LoginPage(),
        "/main_page/": (context) => const MainPage()
      },
    );
  }
}
