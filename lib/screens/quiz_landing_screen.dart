import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/quiz_question_screen.dart';
import 'package:quiz_app/services/gemini_service.dart';
import 'package:quiz_app/theme/app_colors.dart';

/// The screen where users can customize and start a dynamic quiz.
/// This file has been updated with a centered layout and improved UI.
class QuizLandingScreen extends StatefulWidget {
  final String subject;
  final List<String> topics;
  final Color themeColor;

  const QuizLandingScreen(
      {super.key,
      required this.subject,
      required this.topics,
      required this.themeColor});

  @override
  State<QuizLandingScreen> createState() => _QuizLandingScreenState();
}

class _QuizLandingScreenState extends State<QuizLandingScreen> {
  String _difficulty = 'Easy';
  double _questionCount = 5;
  bool _isLoading = false;

  void _startQuiz() async {
    setState(() {
      _isLoading = true;
    });

    final quiz = await GeminiService.generateQuiz(
      subject: widget.subject,
      topics: widget.topics,
      difficulty: _difficulty,
      questionCount: _questionCount.toInt(),
    );

    if (mounted) {
      // Check if the widget is still in the tree before navigating
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizQuestionScreen(quiz: quiz),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.themeColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            // FIX: The main content is now inside a styled card.
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.quizDetailCard,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  // IMPROVEMENT: Added a large, playful icon.
                  Icon(Icons.tune_rounded,
                      size: 80, color: widget.themeColor),
                  const SizedBox(height: 16),
                  Text('Customize Quiz',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brandDarkBlue)),
                  const SizedBox(height: 30),
                  _buildDifficultySelector(),
                  const SizedBox(height: 30),
                  _buildQuestionCountSlider(),
                ],
              ),
            ),
            const Spacer(),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white))
                : ElevatedButton(
                    onPressed: _startQuiz,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: widget.themeColor,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25))),
                    child: Text('Start Quiz',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Difficulty',
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.brandDarkBlue)),
        const SizedBox(height: 10),
        // FIX: Wrapped the SegmentedButton in a Row to center it.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Easy', label: Text('Easy'), icon: Icon(Icons.sentiment_satisfied_alt)),
                ButtonSegment(value: 'Medium', label: Text('Medium'), icon: Icon(Icons.sentiment_neutral)),
                ButtonSegment(value: 'Hard', label: Text('Hard'), icon: Icon(Icons.sentiment_very_dissatisfied)),
              ],
              selected: {_difficulty},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _difficulty = newSelection.first;
                });
              },
              style: SegmentedButton.styleFrom(
                  backgroundColor: AppColors.screenBackground,
                  foregroundColor: AppColors.brandDarkBlue.withOpacity(0.6),
                  selectedForegroundColor: Colors.white,
                  selectedBackgroundColor: widget.themeColor),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionCountSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Number of Questions: ${_questionCount.toInt()}',
            style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.brandDarkBlue)),
        Slider(
          value: _questionCount,
          min: 3,
          max: 10,
          divisions: 7,
          label: _questionCount.toInt().toString(),
          activeColor: widget.themeColor,
          inactiveColor: widget.themeColor.withOpacity(0.3),
          onChanged: (value) {
            setState(() {
              _questionCount = value;
            });
          },
        )
      ],
    );
  }
}
