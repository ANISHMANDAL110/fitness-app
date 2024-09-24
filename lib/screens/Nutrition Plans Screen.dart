// nutrition_plans_screen.dart

import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class NutritionPlansScreen extends StatefulWidget {
  @override
  _NutritionPlansScreenState createState() => _NutritionPlansScreenState();
}

class _NutritionPlansScreenState extends State<NutritionPlansScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> nutritionPlans = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _mealsController = TextEditingController(); // Meals input controller

  @override
  void initState() {
    super.initState();
    fetchNutritionPlans();
  }

  Future<void> fetchNutritionPlans() async {
    nutritionPlans = await _firestoreService.fetchNutritionPlans();
    setState(() {});
  }

  Future<void> addNutritionPlan() async {
    // Handling potential empty inputs
    String title = _titleController.text.isNotEmpty ? _titleController.text : 'Untitled Plan';
    String description = _descriptionController.text.isNotEmpty ? _descriptionController.text : 'No Description';
    List<String> meals = _mealsController.text.isNotEmpty
        ? _mealsController.text.split(',').map((e) => e.trim()).toList()
        : ['No meals provided'];

    await _firestoreService.addNutritionPlan(title, description, meals);

    // Clear input fields
    _titleController.clear();
    _descriptionController.clear();
    _mealsController.clear();

    // Refresh list after adding a new plan
    fetchNutritionPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nutrition Plans'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: nutritionPlans.length,
              itemBuilder: (context, index) {
                final plan = nutritionPlans[index];
                return ListTile(
                  title: Text(plan['title'] ?? 'Untitled Plan'), // Handling null title
                  subtitle: Text(plan['description'] ?? 'No Description'), // Handling null description
                  onTap: () {
                    // Handle nutrition plan details if needed
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Nutrition Plan Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Nutrition Plan Description'),
                ),
                TextField(
                  controller: _mealsController, // Input for meals
                  decoration: InputDecoration(labelText: 'Meals (comma-separated)'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await addNutritionPlan();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nutrition Plan Added!')),
                    );
                  },
                  child: Text('Add Nutrition Plan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
