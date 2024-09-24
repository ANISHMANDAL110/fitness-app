import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class LogWorkoutScreen extends StatefulWidget {
  @override
  _LogWorkoutScreenState createState() => _LogWorkoutScreenState();
}

class _LogWorkoutScreenState extends State<LogWorkoutScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _workoutTitleController = TextEditingController();
  final TextEditingController _workoutDurationController = TextEditingController();

  Future<void> logWorkout() async {
    await _firestoreService.addWorkoutLog(
      _workoutTitleController.text,
      _workoutDurationController.text,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Workout Logged!')),
    );
    _workoutTitleController.clear();
    _workoutDurationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _workoutTitleController,
              decoration: InputDecoration(labelText: 'Workout Title'),
            ),
            TextField(
              controller: _workoutDurationController,
              decoration: InputDecoration(labelText: 'Duration (minutes)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: logWorkout,
              child: Text('Log Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
