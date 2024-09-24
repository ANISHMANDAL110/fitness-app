import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class LogMealScreen extends StatefulWidget {
  @override
  _LogMealScreenState createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _mealTitleController = TextEditingController();
  final TextEditingController _mealCaloriesController = TextEditingController();

  Future<void> logMeal() async {
    await _firestoreService.addMealLog(
      _mealTitleController.text,
      int.parse(_mealCaloriesController.text), // Assuming calories is an integer
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meal Logged!')),
    );
    _mealTitleController.clear();
    _mealCaloriesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Meal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _mealTitleController,
              decoration: InputDecoration(labelText: 'Meal Title'),
            ),
            TextField(
              controller: _mealCaloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: logMeal,
              child: Text('Log Meal'),
            ),
          ],
        ),
      ),
    );
  }
}
