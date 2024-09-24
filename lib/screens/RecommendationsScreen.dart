import 'package:flutter/material.dart';
import 'package:fitness_nutrition_app/firestore_service.dart';

class RecommendationsScreen extends StatefulWidget {
  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  String? userGoal;
  String? userDiet;
  List<String> recommendations = [];

  @override
  void initState() {
    super.initState();
    fetchUserPreferences();
  }

  Future<void> fetchUserPreferences() async {
    String userId = 'example_user_id'; // Replace with actual user ID logic
    final preferences = await _firestoreService.getUserPreferences(userId);
    if (preferences != null) {
      setState(() {
        userGoal = preferences['goal'] as String?;
        userDiet = preferences['diet'] as String?;
      });
      generateRecommendations();
    }
  }

  void generateRecommendations() {
    recommendations.clear(); // Clear previous recommendations

    if (userGoal == 'Weight Loss') {
      recommendations.add('Try HIIT workouts for effective fat loss.');
      recommendations.add('Incorporate strength training to maintain muscle mass.');
    } else if (userGoal == 'Muscle Gain') {
      recommendations.add('Focus on compound exercises like squats and bench press.');
      recommendations.add('Consider meal prep for high-protein meals.');
    }

    if (userDiet == 'Vegan') {
      recommendations.add('Include quinoa and lentils for protein.');
      recommendations.add('Try chia seeds for healthy fats.');
    } else if (userDiet == 'Keto') {
      recommendations.add('Add avocados and nuts to your meals.');
      recommendations.add('Avoid sugary snacks and opt for dark chocolate.');
    }

    setState(() {}); // Update the UI
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          // Inside your ListView.builder for recommendations
          return ListTile(
            title: Text(recommendations[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    // Save positive feedback (e.g., to Firestore)
                  },
                ),
                IconButton(
                  icon: Icon(Icons.thumb_down),
                  onPressed: () {
                    // Save negative feedback (e.g., to Firestore)
                  },
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}
