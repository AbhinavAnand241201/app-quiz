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
    // Get screen width for responsive padding adjustments
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjust horizontal padding based on screen width to prevent squishing on small screens
    final horizontalPadding = screenWidth > 600 ? 60.0 : 20.0; // Larger padding for wider screens

    return Scaffold(
      backgroundColor: widget.themeColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Center the title if you decide to add one later, or just keep leading icon
        centerTitle: true,
      ),
      body: SafeArea( // Use SafeArea to avoid notch/status bar overlap
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.0), // Responsive horizontal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Removed initial Spacer to allow content to adjust more naturally
              // The main content is now inside a styled card.
              Container(
                padding: const EdgeInsets.all(20.0), // Reduced card padding
                decoration: BoxDecoration(
                  color: AppColors.quizDetailCard,
                  borderRadius: BorderRadius.circular(25), // Reduced border radius
                  boxShadow: [ // Added a subtle shadow for better depth
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Make column take minimum space
                  children: [
                    // IMPROVEMENT: Adjusted icon size.
                    Icon(Icons.tune_rounded,
                        size: 60, // Smaller icon size
                        color: widget.themeColor),
                    const SizedBox(height: 12), // Reduced spacing
                    Text('Customize Quiz',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 24, // Smaller font size
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandDarkBlue)),
                    const SizedBox(height: 25), // Adjusted spacing
                    _buildDifficultySelector(),
                    const SizedBox(height: 25), // Adjusted spacing
                    _buildQuestionCountSlider(),
                  ],
                ),
              ),
              const SizedBox(height: 30), // Spacing between card and button
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : ElevatedButton(
                      onPressed: _startQuiz,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: widget.themeColor,
                          padding: const EdgeInsets.symmetric(vertical: 16), // Reduced vertical padding
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text('Start Quiz',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold))),
              const SizedBox(height: 10), // Small spacing at the bottom
            ],
          ),
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
                fontSize: 16, // Slightly smaller font for label
                fontWeight: FontWeight.bold,
                color: AppColors.brandDarkBlue)),
        const SizedBox(height: 8), // Reduced spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ensure the SegmentedButton adjusts to available width if needed, though it's typically fine.
            // Consider using a FittedBox if you encounter overflow issues on very small screens,
            // but for typical mobile screens, it should render well.
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
                  selectedBackgroundColor: widget.themeColor,
                  // Tighter padding for segments to reduce overall button width/height
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: GoogleFonts.poppins(fontSize: 14), // Smaller text for segments
              ),
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
                fontSize: 16, // Slightly smaller font for label
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