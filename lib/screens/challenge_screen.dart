import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/screens/quiz_question_screen.dart';
import 'package:quiz_app/services/quiz_service.dart';
import 'package:quiz_app/theme/app_colors.dart';

/// A screen that presents a special challenge quiz to the user.
class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a new quiz by taking a few random questions from the full list.
    final allQuestions =
        QuizService.quizzes.expand((quiz) => quiz.questions).toList();
    allQuestions.shuffle();
    final challengeQuestions =
        allQuestions.take(5).toList(); // Take 5 random questions

    final challengeQuiz = Quiz(
      title: "Today's Challenge",
      subject: 'Mixed',
      topic: 'Random Questions',
      description: 'A special challenge with questions from all subjects!',
      color: AppColors.challengeBlue,
      icon: Icons.star,
      questions: challengeQuestions,
    );

    return Scaffold(
      backgroundColor: AppColors.challengeBlue,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🎯', style: TextStyle(fontSize: 100)),
              const SizedBox(height: 20),
              Text(
                "Today's Challenge",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'You will face 5 random questions from all subjects. Good luck!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.challengeBlue,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                ),
                onPressed: () {
                  if (challengeQuestions.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QuizQuestionScreen(quiz: challengeQuiz),
                      ),
                    );
                  }
                },
                child: Text('Start Challenge',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
