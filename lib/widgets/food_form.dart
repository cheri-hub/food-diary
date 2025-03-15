import 'package:flutter/material.dart';
import 'package:food_diary/utils/strings.dart';

class FoodForm extends StatefulWidget {
  final Function(String) onSave;

  const FoodForm({super.key, required this.onSave});

  @override
  FoodFormState createState() => FoodFormState();
}

class FoodFormState extends State<FoodForm> {
  final TextEditingController _foodController = TextEditingController();

  void _submit() {
    if (_foodController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.errorInvalidInput)),
      );
      return;
    }
    widget.onSave(_foodController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            onPressed: _submit,
            child: const Text(AppStrings.saveButton),
          ),
        ],
      ),
    );
  }
}
