import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class ProgressTrackingScreen extends StatefulWidget {
  @override
  _ProgressTrackingScreenState createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _workoutNameController = TextEditingController();

  Future<void> logWorkout() async {
    String workoutName = _workoutNameController.text;
    if (workoutName.isNotEmpty) {
      await _firestoreService.logCompletedWorkout(workoutName);
      _workoutNameController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Workout Logged!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _workoutNameController,
              decoration: InputDecoration(labelText: 'Workout Name'),
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
