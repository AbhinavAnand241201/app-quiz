import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/theme/app_colors.dart';

/// The screen that shows a detailed analysis of the user's incorrect answers.
/// This file has been fixed and redesigned for a better user experience.
class TestAnalysisScreen extends StatelessWidget {
  final List<UserAnswer> incorrectAnswers;

  const TestAnalysisScreen({super.key, required this.incorrectAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text('Test Analysis',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: AppColors.brandDarkBlue)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.brandDarkBlue),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        itemCount: incorrectAnswers.length,
        itemBuilder: (context, index) {
          final userAnswer = incorrectAnswers[index];
          return _AnalysisCard(userAnswer: userAnswer);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),
    );
  }
}

/// A redesigned card that clearly explains an incorrect answer.
class _AnalysisCard extends StatelessWidget {
  final UserAnswer userAnswer;
  const _AnalysisCard({required this.userAnswer});

  @override
  Widget build(BuildContext context) {
    final question = userAnswer.question;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The question text.
          Text(question.questionText,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandDarkBlue)),
          const SizedBox(height: 20),
          // The user's incorrect answer, highlighted in pink.
          _AnswerRow(
              label: 'Your Answer:',
              answer: question.options[userAnswer.selectedAnswerIndex],
              color: AppColors.radiantPink,
              icon: Icons.cancel),
          const SizedBox(height: 12),
          // The correct answer, highlighted in green.
          _AnswerRow(
              label: 'Correct Answer:',
              answer: question.options[question.correctAnswerIndex],
              color: AppColors.radiantLime,
              icon: Icons.check_circle),
          const Divider(height: 30),
          // The explanation section.
          Row(
            children: [
              const Icon(Icons.lightbulb_outline_rounded,
                  color: AppColors.buttonGold),
              const SizedBox(width: 8),
              Text('Explanation',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandDarkBlue)),
            ],
          ),
          const SizedBox(height: 8),
          // FIX: Corrected the color error here.
          Text(question.explanation,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.brandDarkBlue.withOpacity(0.7),
                  height: 1.5)),
        ],
      ),
    );
  }
}

/// A redesigned row to display an answer with styling.
class _AnswerRow extends StatelessWidget {
  final String label;
  final String answer;
  final Color color;
  final IconData icon;

  const _AnswerRow(
      {required this.label,
      required this.answer,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Text(label,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, color: AppColors.brandDarkBlue)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(answer,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: color.withOpacity(0.9)))),
        ],
      ),
    );
  }
}
