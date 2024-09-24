import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTabIndex = 0; // Keeps track of the currently selected index

  // Placeholder widgets for each page
  final List<Widget> pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Log Meal Page')),
    Center(child: Text('Log Workout Page')),
    Center(child: Text('View Recommendation Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 20, // Space between rows
                  crossAxisSpacing: 20, // Space between columns
                ),
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return buildIconContainer(
                          FontAwesomeIcons.dumbbell, 'Workouts', () {
                        Navigator.pushNamed(context, '/workout');
                      });
                    case 1:
                      return buildIconContainer(
                          FontAwesomeIcons.appleAlt, 'Nutrition', () {
                        Navigator.pushNamed(context, '/nutrition');
                      });
                    case 2:
                      return buildIconContainer(
                          FontAwesomeIcons.chartLine, 'Progress', () {
                        Navigator.pushNamed(context, '/progress');
                      });
                    case 3:
                      return buildIconContainer(
                          FontAwesomeIcons.userCog, 'User Preferences', () {
                        Navigator.pushNamed(context, '/preferences');
                      });
                    default:
                      return SizedBox.shrink();
                  }
                },
                itemCount: 4, // Total number of items
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildNavBar(), // Use the buildNavBar method
    );
  }

  Widget buildIconContainer(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(label, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget buildNavBar() {
    return BottomNavigationBar(
      currentIndex: selectedTabIndex,
      onTap: (index) {
        setState(() {
          selectedTabIndex = index; // Update the selected tab index
        });

        // Navigate to the corresponding screen
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/'); // Home
            break;
          case 1:
            Navigator.pushNamed(context, '/nutrition'); // Log Meal
            break;
          case 2:
            Navigator.pushNamed(context, '/workout'); // Log Workout
            break;
          case 3:
            Navigator.pushNamed(context, '/recommendations'); // View Recommendations
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.home,
            color: selectedTabIndex == 0 ? Colors.black : Colors.black54, // Black when selected, lighter black when not
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.utensils,
            color: selectedTabIndex == 1 ? Colors.black : Colors.black54, // Black when selected, lighter black when not
          ),
          label: 'Log Meal',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.running,
            color: selectedTabIndex == 2 ? Colors.black : Colors.black54, // Black when selected, lighter black when not
          ),
          label: 'Log Workout',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.lightbulb,
            color: selectedTabIndex == 3 ? Colors.black : Colors.black54, // Black when selected, lighter black when not
          ),
          label: 'Recommendations',
        ),
      ],
    );
  }

}
