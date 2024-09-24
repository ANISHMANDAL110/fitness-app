import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Users Collection
  Future<void> addUser(String name, String email) async {
    await _db.collection('Users').add({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    QuerySnapshot snapshot = await _db.collection('Users').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  // Workout Plans Collection
  Future<void> addWorkoutPlan(String title, String description,
      List<String> exercises) async {
    await _db.collection('WorkoutPlans').add({
      'title': title,
      'description': description,
      'exercises': exercises,
      'duration': '4 weeks', // Example static value
    });
  }

  Future<List<Map<String, dynamic>>> fetchWorkoutPlans() async {
    QuerySnapshot snapshot = await _db.collection('WorkoutPlans').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
  // Nutrition Plans Collection
  Future<void> addNutritionPlan(String title, String description, List<String> meals) async {
    // Ensure meals is not empty and provide a default if it is
    if (meals.isEmpty) {
      meals = ['No meals provided'];
    }

    await _db.collection('NutritionPlans').add({
      'title': title.isNotEmpty ? title : 'Untitled Plan', // Default title if empty
      'description': description.isNotEmpty ? description : 'No Description', // Default description if empty
      'meals': meals, // List of meals
      'duration': '1 week', // Example static value
    });
  }

  // Fetch nutrition plans
  Future<List<Map<String, dynamic>>> fetchNutritionPlans() async {
    var result = await _db.collection('NutritionPlans').get();
    return result.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'title': data['title'] ?? 'No title',
        // Provide default value if null
        'description': data['description'] ?? 'No description',
        // Provide default value if null
        'meals': data['meals'] ?? [],
        // Default to empty list if meals are null
      };
    }).toList();
  }
  // Log Completed Workout
  Future<void> logCompletedWorkout(String workoutName) async {
    await _db.collection('CompletedWorkouts').add({
      'workoutName': workoutName,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  Future<void> addWorkoutLog(String title, String duration) async {
    await _db.collection('WorkoutLogs').add({
      'title': title,
      'duration': duration,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addMealLog(String title, int calories) async {
    await _db.collection('MealLogs').add({
      'title': title,
      'calories': calories,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchWorkoutLogs() async {
    final snapshot = await _db.collection('WorkoutLogs').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<List<Map<String, dynamic>>> fetchMealLogs() async {
    final snapshot = await _db.collection('MealLogs').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Method to save user preferences
  Future<void> saveUserPreferences(Map<String, dynamic> preferences) async {
    String userId = 'example_user_id'; // Replace with actual user ID
    await _db.collection('UserPreferences').doc(userId).set(preferences);
  }
  // Method to fetch recommendations based on user preferences
  Future<Map<String, dynamic>> fetchRecommendations(String userId) async {
    DocumentSnapshot snapshot = await _db.collection('UserPreferences').doc(userId).get();
    if (snapshot.exists) {
      var userPreferences = snapshot.data() as Map<String, dynamic>;

      // Fetch workout recommendation
      QuerySnapshot workoutSnapshot = await _db.collection('WorkoutPlans')
          .where('goal', isEqualTo: userPreferences['goal']) // Filter by goal
          .get();

      // Fetch meal recommendation
      QuerySnapshot mealSnapshot = await _db.collection('NutritionPlans')
          .where('diet', isEqualTo: userPreferences['diet']) // Filter by diet
          .get();

      // Prepare recommendations
      String workoutRecommendation = workoutSnapshot.docs.isNotEmpty
          ? workoutSnapshot.docs.first['title']
          : 'No workout recommendation found';

      String mealRecommendation = mealSnapshot.docs.isNotEmpty
          ? mealSnapshot.docs.first['title']
          : 'No meal recommendation found';

      return {
        'workout': workoutRecommendation,
        'meal': mealRecommendation,
        'goal': userPreferences['goal'],
        'diet': userPreferences['diet'],
      };
    }
    return {};
  }
  Future<void> addUserPreferences(String goal, String diet) async {
    String userId = 'example_user_id'; // Replace with actual user ID
    await _db.collection('UserPreferences').doc(userId).set({
      'goal': goal,
      'diet': diet,
    });
  }
  Future<Map<String, dynamic>?> getUserPreferences(String userId) async {
    DocumentSnapshot snapshot = await _db.collection('UserPreferences').doc(userId).get();
    return snapshot.data() as Map<String, dynamic>?;
  }




}