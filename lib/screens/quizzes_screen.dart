import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/screens/quiz_detail_screen.dart';
import 'package:quiz_app/services/quiz_service.dart';
import '../theme/app_colors.dart';

/// The screen that displays a list of all available quizzes in various subjects.
/// This file has been corrected to prevent crashes and match the design specification.
class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // FIX: The list of quizzes is now correctly fetched from the QuizService,
    // which loads the data from the questions.json file.
    final List<Quiz> quizzes = QuizService.quizzes;

    return Scaffold(
      // FIX: Changed background to the solid yellow color from the design spec.
      backgroundColor: AppColors.quizListBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.brandDarkBlue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.star_rounded,
                color: AppColors.brandDarkBlue.withOpacity(0.8), size: 32),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Quizzes',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.brandDarkBlue,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                // FIX: Using the light cream color for the card as per the spec.
                color: AppColors.quizDetailCard,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              // FIX: The ListView now correctly uses the length of the list
              // from QuizService, which prevents any RangeError.
              child: ListView.separated(
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = quizzes[index];
                  // This logic safely adds a "Due" tag for demonstration.
                  final String? dueDate = (index == 2) ? 'Due 18' : null;
                  return _QuizListItem(
                    quiz: quiz,
                    dueDate: dueDate,
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 30,
                  color: Colors.black12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A single list item representing a quiz, styled according to the design spec.
class _QuizListItem extends StatelessWidget {
  final Quiz quiz;
  final String? dueDate;

  const _QuizListItem({required this.quiz, this.dueDate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizDetailScreen(quiz: quiz)),
        );
      },
      // FIX: The list item is now a simple Row, not a gradient card.
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quiz.subject,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.brandDarkBlue),
                ),
                Text(
                  quiz.topic,
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: AppColors.brandDarkBlue),
                ),
              ],
            ),
          ),
          // Safely display the "Due" tag if it exists.
          if (dueDate != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.buttonGold,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                dueDate!,
                style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandDarkBlue),
              ),
            ),
          const SizedBox(width: 16),
          const Icon(Icons.arrow_forward_ios_rounded,
              color: AppColors.arrowGreen, size: 20),
        ],
      ),
    );
  }
}
