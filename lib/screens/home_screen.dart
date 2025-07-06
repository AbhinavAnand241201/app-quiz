import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/screens/challenge_screen.dart';
import 'package:quiz_app/screens/lesson_screen.dart';
import 'package:quiz_app/services/quiz_service.dart';
import '../theme/app_colors.dart';

/// The main home screen, completely redesigned for a more fun and engaging UI.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = QuizService.quizzes;

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Stack(
        children: [
          Positioned(
              top: 100,
              left: -20,
              child: _Doodle(
                  color: AppColors.radiantPink.withOpacity(0.3), size: 80)),
          Positioned(
              top: 20,
              right: -30,
              child: _Doodle(
                  color: AppColors.radiantCyan.withOpacity(0.3), size: 100)),
          Positioned(
              bottom: 150,
              right: -10,
              child: _Doodle(
                  color: AppColors.buttonGold.withOpacity(0.3), size: 60)),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              children: [
                const SizedBox(height: 10),
                const _AppBar(),
                const SizedBox(height: 24),
                // FIX: "Hello" removed as requested.
                const _SectionHeader(title: 'Trending Quizzes 🔥'),
                const SizedBox(height: 8),
                _TrendingQuizzes(quizzes: subjects.take(3).toList()),
                const SizedBox(height: 24),
                const _TodaysChallenge(),
                const SizedBox(height: 24),
                _SectionHeader(title: 'Explore Subjects 📚'),
                const SizedBox(height: 16),
                _ExploreSubjectsGrid(subjects: subjects),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Doodle extends StatelessWidget {
  final Color color;
  final double size;
  const _Doodle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: Random().nextDouble() * pi,
      child: Container(
        width: size,
        height: size,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

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
            // FIX: "hellorabbi" changed to "hellorabbit"
            Text('hellorabbit',
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

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.brandDarkBlue,
      ),
    );
  }
}

class _TrendingQuizzes extends StatelessWidget {
  final List<Quiz> quizzes;
  const _TrendingQuizzes({required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          return _TrendingQuizCard(quiz: quiz);
        },
      ),
    );
  }
}

class _TrendingQuizCard extends StatelessWidget {
  final Quiz quiz;
  const _TrendingQuizCard({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final lessons = QuizService.lessons[quiz.subject] ?? [];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LessonScreen(quiz: quiz, lessons: lessons)));
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16.0, top: 10, bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: quiz.color,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: quiz.color.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quiz.topic,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text(quiz.subject,
                style: GoogleFonts.poppins(
                    fontSize: 12, color: Colors.white.withOpacity(0.9))),
            const Spacer(),
            Align(
                alignment: Alignment.bottomRight,
                child: Icon(quiz.icon, color: Colors.white, size: 40)),
          ],
        ),
      ),
    );
  }
}

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
            const Text('🎯', style: TextStyle(fontSize: 30)),
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
                  Text("A random mix of questions!",
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

class _ExploreSubjectsGrid extends StatelessWidget {
  final List<Quiz> subjects;
  const _ExploreSubjectsGrid({required this.subjects});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subjectQuiz = subjects[index];
        return _SubjectCard(quiz: subjectQuiz);
      },
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Quiz quiz;
  const _SubjectCard({required this.quiz});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final lessons = QuizService.lessons[quiz.subject] ?? [];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    LessonScreen(quiz: quiz, lessons: lessons)));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: quiz.color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(quiz.icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(quiz.subject,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
