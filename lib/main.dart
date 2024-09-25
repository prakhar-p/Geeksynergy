import 'package:flutter/material.dart';
import 'Screens/Login.dart';
import 'Screens/Menu & Company Info.dart';
import 'Screens/Movie List.dart';
import 'Screens/Signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signup',
      routes: {
        '/signup': (context) => SignupPage(),
        '/login': (context) => LoginPage(),
        '/movies': (context) => HomePage(),
        '/company': (context) => CompanyInfoPage(),
      },
    );
  }
}

