import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/leaderboard_screen.dart';
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
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    QuizzesScreen(),
    LeaderboardScreen(),
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
      // FIX: The BottomNavigationBar has been completely restyled to match the
      // light theme of the HomeScreen as specified in the design document.
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          // FIX: Updated icons to match the design spec.
          _buildNavItem(Icons.home_filled, 'Home'),
          _buildNavItem(Icons.article_rounded, 'Browse'),
          _buildNavItem(Icons.emoji_events_rounded, 'Leaderboard'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // FIX: Changed background color to match the HomeScreen's light background.
        backgroundColor: AppColors.screenBackground,
        type: BottomNavigationBarType.fixed,
        // FIX: Enabled labels as shown in the design screenshot.
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // FIX: Set selected and unselected colors to match the design spec.
        selectedItemColor: AppColors.brandDarkBlue,
        unselectedItemColor: AppColors.textSlightlyDim,
        elevation: 0, // No shadow as per the design.
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
