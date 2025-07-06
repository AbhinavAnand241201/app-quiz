import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/screens/quiz_detail_screen.dart';
import 'package:quiz_app/services/quiz_service.dart';
import 'package:quiz_app/theme/app_colors.dart';

/// A screen that generates a random quiz from all available questions.
class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a new quiz by taking a few random questions from the full list.
    final allQuestions = QuizService.quizzes
        .expand((quiz) => quiz.questions)
        .toList();
    allQuestions.shuffle(); // Randomize the list
    final challengeQuestions = allQuestions.take(5).toList(); // Take 5 random questions

    final challengeQuiz = Quiz(
      title: "Today's Challenge",
      subject: 'Mixed',
      topic: 'Random Questions',
      description: 'A special challenge with questions from all subjects!',
      color: AppColors.challengeBlue,
      icon: Icons.star,
      questions: challengeQuestions,
    );

    // Directly navigate to the QuizDetailScreen for the new challenge quiz.
    // We use a post-frame callback to ensure the build is complete before navigating.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (challengeQuestions.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizDetailScreen(quiz: challengeQuiz),
          ),
        );
      }
    });

    // Show a loading indicator while the navigation is being prepared.
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
