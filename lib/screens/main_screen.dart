import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/leaderboard_screen.dart';
import 'package:quiz_app/screens/profile_screen.dart'; // Import the new profile screen
import 'package:quiz_app/screens/quizzes_screen.dart';
import '../theme/app_colors.dart';

/// The main container for the app, which holds the primary screens
/// and the bottom navigation bar.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // The list of screens accessible from the bottom navigation bar.
  // STEP 5 FIX: Added the ProfileScreen to the list.
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    QuizzesScreen(),
    LeaderboardScreen(),
    ProfileScreen(), // New screen added here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildNavItem(Icons.home_filled, 'Home'),
          _buildNavItem(Icons.article_rounded, 'Browse'),
          _buildNavItem(Icons.emoji_events_rounded, 'Leaderboard'),
          // STEP 5 FIX: Added the new navigation item for the Profile screen.
          _buildNavItem(Icons.person_rounded, 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.screenBackground,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.brandDarkBlue,
        unselectedItemColor: AppColors.textSlightlyDim,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(),
      ),
    );
  }

  /// A helper method to build each BottomNavigationBarItem with consistent styling.
  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon, size: 28),
      label: label,
    );
  }
}
