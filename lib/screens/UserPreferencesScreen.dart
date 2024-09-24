import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class UserPreferencesScreen extends StatefulWidget {
  @override
  _UserPreferencesScreenState createState() => _UserPreferencesScreenState();
}

class _UserPreferencesScreenState extends State<UserPreferencesScreen> {
  final FirestoreService _firestoreService = FirestoreService();

  String? selectedGoal;
  String? selectedDiet;

  final List<String> goals = [
    'Weight Loss',
    'Muscle Gain',
    'Maintain Weight',
  ];

  final List<String> diets = [
    'Vegan',
    'Keto',
    'Paleo',
    'Mediterranean',
    'Gluten-Free',
  ];

  Future<void> savePreferences() async {
    if (selectedGoal != null && selectedDiet != null) {
      // Save the user preferences to Firestore
      await _firestoreService.addUserPreferences(selectedGoal!, selectedDiet!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preferences Saved!')),
      );
      setState(() {
        selectedGoal = null; // Reset selection
        selectedDiet = null; // Reset selection
      });
    } else {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedGoal,
              hint: Text('Select Your Goal'),
              items: goals.map((goal) {
                return DropdownMenuItem(
                  value: goal,
                  child: Text(goal),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGoal = value;
                });
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedDiet,
              hint: Text('Select Your Diet Preference'),
              items: diets.map((diet) {
                return DropdownMenuItem(
                  value: diet,
                  child: Text(diet),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedDiet = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: savePreferences,
              child: Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}
