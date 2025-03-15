import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../widgets/meal_card.dart';
import '../utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // ✅ Carrega as refeições do banco de dados quando a tela for aberta
    Provider.of<FoodProvider>(context, listen: false).loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    final foodProvider = Provider.of<FoodProvider>(context);
    final meals = foodProvider.meals;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appName)),
      body: meals.isEmpty
          ? const Center(child: Text(AppStrings.emptyMessage))
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];

                return Dismissible(
                  key: Key(meal.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    foodProvider.deleteMeal(meal.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Refeição removida!')),
                    );
                  },
                  child: MealCard(meal: meal),
                );
              },
            ),

      // ✅ Botão flutuante para adicionar refeição
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.pushNamed(context, '/add-meal');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
