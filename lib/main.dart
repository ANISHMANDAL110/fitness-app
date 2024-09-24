import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/Home Screen.dart'; // Ensure there are no spaces in filenames
import 'screens/Login Screen.dart';
import 'screens/Signup Screen.dart';
import 'screens/Workout Plans Screen.dart';
import 'screens/Nutrition Plans Screen.dart';
import 'screens/Progress Tracking Screen.dart';
import 'screens/RecommendationsScreen.dart'; // Import recommendations screen
import 'screens/UserPreferencesScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness & Nutrition App',
      home: AuthWrapper(),
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/workout': (context) => WorkoutPlansScreen(),
        '/nutrition': (context) => NutritionPlansScreen(),
        '/progress': (context) => ProgressTrackingScreen(),
        '/preferences': (context) => UserPreferencesScreen(),
        '/recommendations': (context) => RecommendationsScreen(), // Add route
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // If the user is logged in, show the home screen; otherwise, show the login screen.
    if (user != null) {
      return HomeScreen();
    } else {
      return LoginScreen(); // Redirect to login screen
    }
  }
}
