import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/quizzes_screen.dart';
import 'package:quiz_app/services/quiz_service.dart';
import '../theme/app_colors.dart';

// Placeholder screens for navigation
class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text("Today's Challenge")),
      body: const Center(child: Text("Challenge Screen")));
}

class SubjectDetailScreen extends StatelessWidget {
  final String subjectName;
  const SubjectDetailScreen({super.key, required this.subjectName});
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(subjectName)),
      body: Center(child: Text("$subjectName Quizzes")));
}

/// The main home screen of the application.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: const [
            SizedBox(height: 10),
            _AppBar(),
            SizedBox(height: 24),
            _Header(),
            SizedBox(height: 8),
            _TrendingQuizzes(),
            SizedBox(height: 24),
            _TodaysChallenge(),
            SizedBox(height: 24),
            _QuickQuestion(),
          ],
        ),
      ),
    );
  }
}

// AppBar remains the same
class _AppBar extends StatelessWidget {
  const _AppBar();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text('🐰', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 8),
            Text('hellorabbi',
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandDarkBlue)),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.buttonGold,
              borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.star_rounded, color: Colors.white, size: 24),
        ),
      ],
    );
  }
}

// Header remains the same
class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Text('Hello\nTrending Quizzes',
        style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.brandDarkBlue,
            height: 1.2));
  }
}

/// The horizontally scrolling list of trending quiz cards.
class _TrendingQuizzes extends StatelessWidget {
  const _TrendingQuizzes();

  @override
  Widget build(BuildContext context) {
    // FIX: Using the new public getter `QuizService.quizzes`.
    final trending = QuizService.quizzes.take(3).toList();
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: trending.length,
        itemBuilder: (context, index) {
          final quiz = trending[index];
          return _TrendingQuizCard(
            title: quiz.topic,
            details: '${quiz.subject} • Grade ${index + 1}',
            character: '🧠',
            color: quiz.color,
          );
        },
      ),
    );
  }
}

/// A single card representing a trending quiz. Now tappable.
class _TrendingQuizCard extends StatelessWidget {
  final String title, details, character;
  final Color color;

  const _TrendingQuizCard(
      {required this.title,
      required this.details,
      required this.character,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const QuizzesScreen()));
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16.0, top: 10, bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(details,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: Colors.white.withOpacity(0.9))),
            const Spacer(),
            Align(
                alignment: Alignment.bottomRight,
                child: Text(character, style: const TextStyle(fontSize: 40))),
          ],
        ),
      ),
    );
  }
}

/// The "Today's Challenge" banner widget. Now tappable.
class _TodaysChallenge extends StatelessWidget {
  const _TodaysChallenge();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ChallengeScreen()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
            color: AppColors.challengeBlue,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            const Text('🚲', style: TextStyle(fontSize: 30)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Today's Challenge",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16)),
                  Text("Win 10 points to earn a bike",
                      style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.8), fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// QuickQuestion remains the same
class _QuickQuestion extends StatelessWidget {
  const _QuickQuestion();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("How much is 1 + 2?",
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.brandDarkBlue)),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonGold,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              shadowColor: AppColors.buttonGold.withOpacity(0.5)),
          onPressed: () {},
          child: Text('Go',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandDarkBlue)),
        ),
      ],
    );
  }
}
