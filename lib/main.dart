import 'package:flutter/material.dart';
import 'package:phone_book/home/lunch_screen/view/dashboard_screen.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 97, 99, 101)),
        useMaterial3: true,
      ),
      home:  const ModuleScreen(),
    );
  }
}

