import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class MealLogScreen extends StatefulWidget {
  @override
  _MealLogScreenState createState() => _MealLogScreenState();
}

class _MealLogScreenState extends State<MealLogScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> mealLogs = [];

  @override
  void initState() {
    super.initState();
    fetchMealLogs();
  }

  Future<void> fetchMealLogs() async {
    mealLogs = await _firestoreService.fetchMealLogs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Logs'),
      ),
      body: ListView.builder(
        itemCount: mealLogs.length,
        itemBuilder: (context, index) {
          final log = mealLogs[index];
          return ListTile(
            title: Text(log['title']),
            subtitle: Text('Calories: ${log['calories']}'),
          );
        },
      ),
    );
  }
}
