import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/mood.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/mood': (context) => const MoodPage()
      },
    );
  }
}
