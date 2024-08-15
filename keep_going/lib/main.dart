import 'package:flutter/material.dart';
import 'package:keep_going/presentation/screens/home/home_screen.dart';

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
                  const Color.fromARGB(255, 241, 209, 220),
                  const Color.fromARGB(255, 223, 200, 193),
                  Color.fromARGB(255, 255, 165, 119),
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