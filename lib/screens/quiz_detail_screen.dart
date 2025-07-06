import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/quiz_question_screen.dart';
import '../models/quiz_model.dart';
import '../theme/app_colors.dart';

/// Displays the details of a selected quiz before starting.
/// This screen has been updated to precisely match the design specification.
class QuizDetailScreen extends StatelessWidget {
  final Quiz quiz;

  const QuizDetailScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FIX: Changed background to the solid orange color from the design spec.
      backgroundColor: AppColors.quizDetailBackground,
      appBar: AppBar(
        // FIX: Using a standard AppBar for cleaner structure.
        leading: IconButton(
          // FIX: Icon color changed to be visible on the orange background.
          icon: const Icon(Icons.arrow_back, color: AppColors.brandDarkBlue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header text for the quiz title.
              Text(
                quiz.title, // Using dynamic title from the quiz object.
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  // FIX: Corrected font size and color to match the spec.
                  color: AppColors.brandDarkBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              // Main content card containing the description and icon.
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    // FIX: Changed to a solid cream color with a large border radius.
                    color: AppColors.quizDetailCard,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Quiz description text.
                      Text(
                        quiz.description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          // FIX: Corrected text color for readability on the light card.
                          color: AppColors.brandDarkBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      // Large icon representing the quiz.
                      Icon(quiz.icon,
                          size: 120, color: AppColors.challengeBlue),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // The "Start" button.
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // FIX: Corrected button colors and border radius to match the spec.
                  backgroundColor: AppColors.challengeBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizQuestionScreen(quiz: quiz),
                    ),
                  );
                },
                child: Text(
                  'Start • ${quiz.questions.length} Questions',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
