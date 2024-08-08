import 'package:flutter/material.dart';
import 'package:keep_going/presentation/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Going',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.pinkAccent.shade100,
                  Colors.purpleAccent.shade200,
                  Colors.purpleAccent.shade700,
                ]
                ),
            ),
            child: const SafeArea(child: HomeScreen())
          ),
        ),
      ),
    );
  }
}