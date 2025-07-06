import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/quiz_model.dart'; // Assuming LeaderboardUser is here
import '../theme/app_colors.dart';

/// Displays the results of a completed quiz.
/// This screen has been updated to precisely match the design specification.
class QuizResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for the student list, as it's part of this screen's design.
    final List<Map<String, String>> students = [
      {'name': 'Emma', 'status': 'Perfect', 'score': '10/10'},
      {'name': 'Good', 'status': 'Good', 'score': '7/10'},
    ];

    return Scaffold(
      // FIX: Changed background to the solid teal color from the design spec.
      backgroundColor: AppColors.quizResultsBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Placeholder for the clipboard smiley icon.
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child:
                const Icon(Icons.assignment_turned_in_outlined, color: Colors.white, size: 28),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header text.
            Text(
              'Quiz Results',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Main score card.
            _MainScoreCard(score: score, totalQuestions: totalQuestions),
            const SizedBox(height: 20),
            // Students list card.
            _StudentsListCard(students: students),
          ],
        ),
      ),
    );
  }
}

/// The main card displaying the user's score.
class _MainScoreCard extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const _MainScoreCard({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        // FIX: Using the light cream color from the spec.
        color: AppColors.quizResultsCard,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          // Placeholder for the yellow smiley icon.
          const Icon(Icons.sentiment_satisfied,
              color: AppColors.buttonGold, size: 80),
          const SizedBox(height: 16),
          Text(
            '$score/$totalQuestions',
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: AppColors.brandDarkBlue,
            ),
          ),
        ],
      ),
    );
  }
}

/// The card displaying the list of other students' results.
class _StudentsListCard extends StatelessWidget {
  final List<Map<String, String>> students;

  const _StudentsListCard({required this.students});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // FIX: Using a slightly lighter teal for the card background.
        color: AppColors.quizResultsBackground.withBlue(190).withGreen(182),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Students',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          // Using ListView.separated to easily add dividers.
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return _StudentListItem(
                name: student['name']!,
                status: student['status']!,
                score: student['score']!,
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withOpacity(0.5),
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

/// A single list item representing a student's result.
class _StudentListItem extends StatelessWidget {
  final String name;
  final String status;
  final String score;

  const _StudentListItem(
      {required this.name, required this.status, required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Placeholder for the student avatar.
        const CircleAvatar(
          backgroundColor: AppColors.podiumPink,
          radius: 22,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandDarkBlue),
            ),
            Text(
              status,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: AppColors.brandDarkBlue),
            ),
          ],
        ),
        const Spacer(),
        Text(
          score,
          style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.brandDarkBlue),
        ),
      ],
    );
  }
}
