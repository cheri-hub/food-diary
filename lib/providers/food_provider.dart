import 'package:flutter/material.dart';
import '../models/food_entry.dart';
import '../database/database_helper.dart';

class FoodProvider with ChangeNotifier {
  final List<FoodEntry> _meals =
      []; // Final para garantir que a referência não mude

  List<FoodEntry> get meals =>
      List.unmodifiable(_meals); // Protege a lista de modificações externas

  // Carregar refeições do banco de dados
  Future<void> loadMeals() async {
    try {
      final dbMeals = await DatabaseHelper().getAllMeals();
      _meals.clear();
      _meals.addAll(dbMeals);
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao carregar refeições: $e");
    }
  }

  // Adicionar refeição
  Future<void> addMeal(String name) async {
    try {
      final newMeal = FoodEntry(name: name, date: DateTime.now());
      final int id = await DatabaseHelper()
          .insertMeal(newMeal); // ID sempre será int válido
      _meals.add(FoodEntry(id: id, name: name, date: newMeal.date));
      notifyListeners();
    } catch (e) {
      debugPrint("Erro ao adicionar refeição: $e");
    }
  }

  // Deletar refeição
  Future<void> deleteMeal(int id) async {
    try {
      final rowsDeleted = await DatabaseHelper().deleteMeal(id);
      if (rowsDeleted > 0) {
        _meals.removeWhere((meal) => meal.id == id);
        notifyListeners();
      } else {
        debugPrint("Nenhuma refeição encontrada para deletar com ID: $id");
      }
    } catch (e) {
      debugPrint("Erro ao deletar refeição: $e");
    }
  }
}
