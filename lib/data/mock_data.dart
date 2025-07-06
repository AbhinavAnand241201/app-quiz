
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

  // --- Existing Quiz & Leaderboard Data ---
  static final List<Quiz> quizzes = [
    Quiz(
      title: 'Math Quiz',
      subject: 'Math',
      topic: 'Algebra',
      description: 'A fun quiz about basic algebra!',
      color: AppColors.radiantOrange,
      icon: Icons.calculate_rounded,
      questions: [
        Question(
            questionText: 'What is x in x + 5 = 10?',
            options: ['3', '4', '5', '6'],
            correctAnswerIndex: 2)
      ],
    ),
    Quiz(
      title: 'Science Quiz',
      subject: 'Science',
      topic: 'Animals',
      description: 'How much do you know about the animal kingdom?',
      color: AppColors.radiantPink,
      icon: Icons.pets,
      questions: [
        Question(
            questionText: 'What is the fastest land animal?',
            options: ['Lion', 'Tiger', 'Cheetah'],
            correctAnswerIndex: 2)
      ],
    ),
  ];
  static final List<LeaderboardUser> leaderboard = [
    LeaderboardUser(
        name: 'Daniel',
        score: 95,
        avatarUrl: 'https://i.pravatar.cc/150?u=daniel'),
  ];
}
