import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class WorkoutPlansScreen extends StatefulWidget {
  @override
  _WorkoutPlansScreenState createState() => _WorkoutPlansScreenState();
}

class _WorkoutPlansScreenState extends State<WorkoutPlansScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  List<Map<String, dynamic>> workoutPlans = [];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _exercisesController = TextEditingController(); // New controller for exercises

  @override
  void initState() {
    super.initState();
    fetchWorkoutPlans();
  }

  Future<void> fetchWorkoutPlans() async {
    workoutPlans = await _firestoreService.fetchWorkoutPlans();
    setState(() {});
  }

  Future<void> addWorkoutPlan() async {
    List<String> exercises = _exercisesController.text.split(',').map((e) => e.trim()).toList(); // Split and trim exercises
    await _firestoreService.addWorkoutPlan(
      _titleController.text,
      _descriptionController.text,
      exercises, // Pass the list of exercises
    );
    _titleController.clear();
    _descriptionController.clear();
    _exercisesController.clear(); // Clear exercises input
    fetchWorkoutPlans(); // Refresh the list after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Plans'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: workoutPlans.length,
              itemBuilder: (context, index) {
                final plan = workoutPlans[index];
                return ListTile(
                  title: Text(plan['title']),
                  subtitle: Text(plan['description']),
                  onTap: () {
                    // Handle workout details if needed
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
                  decoration: InputDecoration(labelText: 'Workout Title'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Workout Description'),
                ),
                TextField(
                  controller: _exercisesController, // New input for exercises
                  decoration: InputDecoration(labelText: 'Exercises (comma-separated)'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await addWorkoutPlan();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Workout Plan Added!')),
                    );
                  },
                  child: Text('Add Workout Plan'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
