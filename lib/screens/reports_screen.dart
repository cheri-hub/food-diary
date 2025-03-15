import 'package:flutter/material.dart';
import 'package:food_diary/utils/strings.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final meals = foodProvider.meals;

    if (meals.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.reportTitle)),
        body: const Center(child: Text(AppStrings.noReportData)),
      );
    }

    // Cálculo de estatísticas simples
    final totalMeals = meals.length;
    final firstMealDate = meals.first.date;
    final lastMealDate = meals.last.date;
    final formattedFirstDate = DateFormat('dd/MM/yyyy').format(firstMealDate);
    final formattedLastDate = DateFormat('dd/MM/yyyy').format(lastMealDate);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.reportTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.diaryStatistics,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('${AppStrings.totalMeals} $totalMeals'),
            Text('${AppStrings.firstMeal} $formattedFirstDate'),
            Text('${AppStrings.lastMeal} $formattedLastDate'),
            const SizedBox(height: 20),
            const Text(
              AppStrings.last5Meals,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: meals.length < 5 ? meals.length : 5,
                itemBuilder: (context, index) {
                  final meal = meals[meals.length - 1 - index];
                  return ListTile(
                    title: Text(meal.name),
                    subtitle:
                        Text(DateFormat('dd/MM/yyyy HH:mm').format(meal.date)),
                    leading: const Icon(Icons.fastfood, color: Colors.orange),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
