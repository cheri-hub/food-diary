import 'package:flutter/material.dart';
import '../models/food_entry.dart';
import '../utils/strings.dart';
import 'package:intl/intl.dart';

class MealCard extends StatelessWidget {
  final FoodEntry meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.fastfood, color: Colors.orange),
        title: Text(
          meal.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "${AppStrings.consumedOn} ${DateFormat('dd/MM/yyyy HH:mm').format(meal.date)}",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
