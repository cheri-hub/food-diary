import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/add_meal_screen.dart';
import 'providers/food_provider.dart';
import 'screens/reports_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FoodProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Diário Alimentar', routes: {
      '/': (context) => const HomeScreen(),
      '/add-meal': (context) => const AddMealScreen(),
      '/reports': (context) => const ReportsScreen(),
    });
  }
}
