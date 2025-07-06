import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/screens/test_analysis_screen.dart';
import '../theme/app_colors.dart';
import '../screens/main_screen.dart';

/// Displays the results of a completed quiz with dynamic feedback and analysis.
class QuizResultsScreen extends StatefulWidget {
  // Now accepts a list of UserAnswer objects instead of just the score.
  final List<UserAnswer> userAnswers;

  const QuizResultsScreen({
    Key? key,
    required this.userAnswers,
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
      duration: const Duration(milliseconds: 600),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate score and incorrect answers from the passed list.
    final int totalQuestions = widget.userAnswers.length;
    final int score =
        widget.userAnswers.where((answer) => answer.isCorrect).length;
    final incorrectAnswers =
        widget.userAnswers.where((answer) => !answer.isCorrect).toList();

    final double percentage = totalQuestions > 0 ? score / totalQuestions : 0;
    String message;
    String emoji;

    // STEP 1: Dynamic emoji based on performance.
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _animation,
                child: _MainScoreCard(
                    score: score,
                    totalQuestions: totalQuestions,
                    emoji: emoji,
                    message: message),
              ),
              const SizedBox(height: 30),
              // The "Test Analysis" button, which only appears if there were mistakes.
              if (incorrectAnswers.isNotEmpty)
                _AnalysisButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestAnalysisScreen(
                            incorrectAnswers: incorrectAnswers),
                      ),
                    );
                  },
                ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainScoreCard extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String emoji;
  final String message;

  const _MainScoreCard(
      {required this.score,
      required this.totalQuestions,
      required this.emoji,
      required this.message});

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
          Text(message,
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandDarkBlue)),
          const SizedBox(height: 8),
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

class _AnalysisButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _AnalysisButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.brandDarkBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      icon: const Icon(Icons.analytics_outlined),
      label: Text('Test Analysis',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
    );
  }
}
