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
    // Adjusted horizontal padding to be slightly less on small screens for more room
    final horizontalPadding = screenWidth > 600 ? 60.0 : 16.0; // Reduced to 16.0 from 20.0 for smaller screens

    return Scaffold(
      backgroundColor: widget.themeColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0), // Further reduced card padding from 20.0 to 16.0
                decoration: BoxDecoration(
                  color: AppColors.quizDetailCard,
                  borderRadius: BorderRadius.circular(20), // Slightly reduced border radius to 20
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.tune_rounded,
                        size: 55, // Slightly smaller icon size from 60 to 55
                        color: widget.themeColor),
                    const SizedBox(height: 10), // Reduced spacing
                    Text('Customize Quiz',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 22, // Slightly smaller font size from 24 to 22
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandDarkBlue)),
                    const SizedBox(height: 20), // Adjusted spacing
                    _buildDifficultySelector(),
                    const SizedBox(height: 20), // Adjusted spacing
                    _buildQuestionCountSlider(),
                  ],
                ),
              ),
              const SizedBox(height: 25), // Spacing between card and button
              _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.white))
                  : ElevatedButton(
                      onPressed: _startQuiz,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: widget.themeColor,
                          padding: const EdgeInsets.symmetric(vertical: 15), // Reduced vertical padding from 16 to 15
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: Text('Start Quiz',
                          style: GoogleFonts.poppins(
                              fontSize: 17, // Slightly smaller font for button
                              fontWeight: FontWeight.bold))),
              const SizedBox(height: 10),
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
                fontSize: 15, // Slightly smaller font for label
                fontWeight: FontWeight.bold,
                color: AppColors.brandDarkBlue)),
        const SizedBox(height: 6), // Reduced spacing
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FIX for SegmentedButton overflow:
            // 1. Reduced horizontal padding for segments.
            // 2. Reduced textStyle font size for segments.
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Easy', label: Text('Easy'), icon: Icon(Icons.sentiment_satisfied_alt, size: 18)), // Smaller icon
                ButtonSegment(value: 'Medium', label: Text('Medium'), icon: Icon(Icons.sentiment_neutral, size: 18)), // Smaller icon
                ButtonSegment(value: 'Hard', label: Text('Hard'), icon: Icon(Icons.sentiment_very_dissatisfied, size: 18)), // Smaller icon
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6), // Further reduced padding (from 12,8 to 8,6)
                  textStyle: GoogleFonts.poppins(fontSize: 13), // Further reduced text size (from 14 to 13)
                  // Minimum size for the button to allow more content in smaller screens.
                  // This can sometimes help if the segments try to be too large.
                  minimumSize: const Size(0, 36) // Set a minimum height for the segments
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
                fontSize: 15, // Slightly smaller font for label
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