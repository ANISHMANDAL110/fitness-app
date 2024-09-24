import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class WorkoutLogScreen extends StatefulWidget {
  @override
  _WorkoutLogScreenState createState() => _WorkoutLogScreenState();
}

class _WorkoutLogScreenState extends State<WorkoutLogScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> workoutLogs = [];

  @override
  void initState() {
    super.initState();
    fetchWorkoutLogs();
  }

  Future<void> fetchWorkoutLogs() async {
    workoutLogs = await _firestoreService.fetchWorkoutLogs();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Logs'),
      ),
      body: ListView.builder(
        itemCount: workoutLogs.length,
        itemBuilder: (context, index) {
          final log = workoutLogs[index];
          return ListTile(
            title: Text(log['title']),
            subtitle: Text('Duration: ${log['duration']} minutes'),
          );
        },
      ),
    );
  }
}
