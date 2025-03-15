import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../utils/strings.dart';

class AddMealScreen extends StatefulWidget {
  const AddMealScreen({super.key});

  @override
  AddMealScreenState createState() => AddMealScreenState();
}

class AddMealScreenState extends State<AddMealScreen> {
  final TextEditingController _foodController = TextEditingController();

  void _saveMeal() async {
    final foodName = _foodController.text.trim();

    if (foodName.isEmpty) {
      // Exibe um aviso caso o usuário tente salvar sem preencher o nome do alimento
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O nome do alimento não pode estar vazio.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Obtém o Provider e adiciona a refeição ao banco de dados
      final foodProvider = Provider.of<FoodProvider>(context, listen: false);

      // Exibir indicador de carregamento
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      await foodProvider.addMeal(foodName);

      // Fechar o indicador de carregamento
      Navigator.of(context).pop();

      // Exibe um aviso confirmando o salvamento
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Refeição salva com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Fecha a tela e retorna para a tela inicial
      Navigator.pop(context);
    } catch (e) {
      // Garante que o indicador de carregamento será fechado antes de exibir o erro
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar refeição: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addMealTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _foodController,
              decoration:
                  const InputDecoration(labelText: AppStrings.foodInputHint),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMeal,
              child: const Text(AppStrings.saveButton),
            ),
          ],
        ),
      ),
    );
  }
}
