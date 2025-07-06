import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../screens/main_screen.dart';

/// Displays the results of a completed quiz with dynamic feedback.
class QuizResultsScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const QuizResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  State<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends State<QuizResultsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double percentage =
        widget.totalQuestions > 0 ? widget.score / widget.totalQuestions : 0;
    String message;
    String emoji;

    // STEP 1 FIX: Use different emojis based on performance.
    if (percentage >= 0.9) {
      message = 'Excellent!';
      emoji = '🥳';
    } else if (percentage >= 0.7) {
      message = 'Great Job!';
      emoji = '🤩';
    } else if (percentage >= 0.4) {
      message = 'Good Try!';
      emoji = '👍';
    } else {
      message = 'Keep Practicing!';
      emoji = '🤔';
    }

    return Scaffold(
      backgroundColor: AppColors.quizResultsBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: _MainScoreCard(
                  score: widget.score,
                  totalQuestions: widget.totalQuestions,
                  emoji: emoji),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainScoreCard extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String emoji;

  const _MainScoreCard(
      {required this.score,
      required this.totalQuestions,
      required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
          color: AppColors.quizResultsCard,
          borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 100)),
          const SizedBox(height: 16),
          Text('$score/$totalQuestions',
              style: GoogleFonts.poppins(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandDarkBlue)),
        ],
      ),
    );
  }
}
