import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/mock_data.dart';
import '../theme/app_colors.dart';

/// The main home screen of the application, now with additional content sections.
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
            SizedBox(height: 24),
            // --- NEW CONTENT ADDED BELOW ---
            _SectionHeader(title: 'Continue Learning 🚀'),
            SizedBox(height: 16),
            _ContinueLearningSection(),
            SizedBox(height: 24),
            _SectionHeader(title: 'Explore Subjects 🗺️'),
            SizedBox(height: 16),
            _ExploreSubjectsGrid(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// --- EXISTING WIDGETS (No changes needed) ---

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

class _TrendingQuizzes extends StatelessWidget {
  const _TrendingQuizzes();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: MockData.trendingQuizzesHome.length,
        itemBuilder: (context, index) {
          final quiz = MockData.trendingQuizzesHome[index];
          return _TrendingQuizCard(
              title: quiz['title']!,
              details: quiz['details']!,
              character: quiz['character']!,
              color: quiz['color']!);
        },
      ),
    );
  }
}

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
    return Container(
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
    );
  }
}

class _TodaysChallenge extends StatelessWidget {
  const _TodaysChallenge();
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

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

// --- NEW WIDGETS ADDED BELOW ---

/// A reusable header for the new content sections.
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

/// The new "Continue Learning" section widget.
class _ContinueLearningSection extends StatelessWidget {
  const _ContinueLearningSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemCount: MockData.continueLearning.length,
        itemBuilder: (context, index) {
          final item = MockData.continueLearning[index];
          return _ContinueLearningCard(
            title: item['title'],
            subject: item['subject'],
            progress: item['progress'],
            icon: item['icon'],
            color: item['color'],
          );
        },
      ),
    );
  }
}

/// A card for the "Continue Learning" section.
class _ContinueLearningCard extends StatelessWidget {
  final String title, subject;
  final double progress;
  final IconData icon;
  final Color color;

  const _ContinueLearningCard({
    required this.title,
    required this.subject,
    required this.progress,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16, bottom: 10, top: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.quizDetailCard, // Using light card color
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(subject,
                  style: GoogleFonts.poppins(
                      color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandDarkBlue)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: color.withOpacity(0.2),
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

/// The new "Explore Subjects" grid widget.
class _ExploreSubjectsGrid extends StatelessWidget {
  const _ExploreSubjectsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Using 3 columns for a more compact look
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemCount: MockData.subjects.length,
      itemBuilder: (context, index) {
        final subject = MockData.subjects[index];
        return _SubjectCard(
          name: subject['name'],
          icon: subject['icon'],
          color: subject['color'],
        );
      },
    );
  }
}

/// A card for the "Explore Subjects" grid.
class _SubjectCard extends StatelessWidget {
  final String name, icon;
  final Color color;

  const _SubjectCard(
      {required this.name, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(name,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
