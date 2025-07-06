import 'package:flutter/material.dart';
import 'package:quiz_app/theme/app_colors.dart';
import '../models/quiz_model.dart';

/// This class holds all the mock data used throughout the app.
class MockData {
  /// Data for the "Trending Quizzes" section on the HomeScreen.
  static final List<Map<String, dynamic>> trendingQuizzesHome = [
    {
      'title': 'Addition',
      'details': 'Math • Grade 3',
      'character': '🧮',
      'color': AppColors.cardRed,
    },
    {
      'title': 'Animals',
      'details': 'Science • Grade 2',
      'character': '🦁',
      'color': AppColors.podiumBlue,
    },
    {
      'title': 'Shapes',
      'details': 'Art • Grade 1',
      'character': '🎨',
      'color': AppColors.podiumYellow,
    },
  ];

  /// ADDED: Data for the "Continue Learning" section.
  static final List<Map<String, dynamic>> continueLearning = [
    {
      'title': 'Fractions',
      'subject': 'Math',
      'progress': 0.6,
      'icon': Icons.pie_chart,
      'color': AppColors.radiantLime,
    },
    {
      'title': 'Planets',
      'subject': 'Science',
      'progress': 0.3,
      'icon': Icons.public,
      'color': AppColors.radiantCyan,
    },
  ];

  /// ADDED: Data for the "Explore Subjects" section.
  static final List<Map<String, dynamic>> subjects = [
    {'name': 'Math', 'icon': '➕', 'color': AppColors.radiantOrange},
    {'name': 'Science', 'icon': '🔬', 'color': AppColors.radiantCyan},
    {'name': 'History', 'icon': '📜', 'color': AppColors.buttonGold},
    {'name': 'Art', 'icon': '🎨', 'color': AppColors.radiantPink},
    {'name': 'Music', 'icon': '🎵', 'color': AppColors.podiumPink},
    {'name': 'Geography', 'icon': '🗺️', 'color': AppColors.arrowGreen},
  ];

  /// Data for the LeaderboardScreen.
  /// This list has been expanded to provide a more complete view.
  static final List<LeaderboardUser> leaderboard = [
    LeaderboardUser(
        name: 'Daniel',
        score: 95,
        avatarUrl: 'https://i.pravatar.cc/150?u=daniel'),
    LeaderboardUser(
        name: 'Mia', score: 88, avatarUrl: 'https://i.pravatar.cc/150?u=mia'),
    LeaderboardUser(
        name: 'Leo', score: 82, avatarUrl: 'https://i.pravatar.cc/150?u=leo'),
    LeaderboardUser(
        name: 'Zoe', score: 75, avatarUrl: 'https://i.pravatar.cc/150?u=zoe'),
    LeaderboardUser(
        name: 'Alex', score: 74, avatarUrl: 'https://i.pravatar.cc/150?u=alex'),
    LeaderboardUser(
        name: 'Ruby', score: 68, avatarUrl: 'https://i.pravatar.cc/150?u=ruby'),
    LeaderboardUser(
        name: 'Finn', score: 65, avatarUrl: 'https://i.pravatar.cc/150?u=finn'),
    LeaderboardUser(
        name: 'Chloe', score: 61, avatarUrl: 'https://i.pravatar.cc/150?u=chloe'),
  ];
}
