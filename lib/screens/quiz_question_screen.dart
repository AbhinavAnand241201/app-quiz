import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/quiz_results_screen.dart';
import '../models/quiz_model.dart';
import '../theme/app_colors.dart';

/// The screen where the user actively answers quiz questions.
/// This file has been corrected to pass all necessary data to the results screen.
class QuizQuestionScreen extends StatefulWidget {
  final Quiz quiz;
  const QuizQuestionScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  _QuizQuestionScreenState createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  final List<UserAnswer> _userAnswers = [];

  void _answerQuestion(int selectedIndex) {
    setState(() {
      _selectedAnswerIndex = selectedIndex;
      _userAnswers.add(UserAnswer(
        question: widget.quiz.questions[_currentQuestionIndex],
        selectedAnswerIndex: selectedIndex,
      ));
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswerIndex = null;
        });
      } else {
        // When the quiz is over, navigate to the results screen.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizResultsScreen(
              userAnswers: _userAnswers,
              // FIX: Passing the subject to the results screen is crucial for history.
              // This was the missing piece of logic.
              subject: widget.quiz.subject,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion =
        widget.quiz.questions[_currentQuestionIndex];
    final double progress =
        (_currentQuestionIndex + 1) / widget.quiz.questions.length;

    return Scaffold(
      backgroundColor: widget.quiz.color,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.quiz.title,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.radiantLime),
                minHeight: 8,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.quizDetailCard,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                currentQuestion.questionText,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brandDarkBlue),
              ),
            ),
            const Spacer(),
            ...List.generate(currentQuestion.options.length, (index) {
              return _Option(
                optionText: currentQuestion.options[index],
                isSelected: _selectedAnswerIndex == index,
                isCorrect: index == currentQuestion.correctAnswerIndex,
                hasBeenSelected: _selectedAnswerIndex != null,
                onTap: () => _answerQuestion(index),
              );
            }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final bool hasBeenSelected;
  final VoidCallback onTap;

  const _Option({
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    required this.hasBeenSelected,
    required this.onTap,
  });

  Color _getBackgroundColor() {
    if (hasBeenSelected) {
      if (isSelected) {
        return isCorrect ? AppColors.radiantLime : AppColors.radiantPink;
      } else if (isCorrect) {
        return AppColors.radiantLime;
      }
    }
    return AppColors.quizDetailCard;
  }

  Widget _getIcon() {
    if (hasBeenSelected && isSelected) {
      return Text(isCorrect ? '✅' : '❌', style: const TextStyle(fontSize: 24));
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.05 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: GestureDetector(
        onTap: hasBeenSelected ? null : onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  optionText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandDarkBlue,
                  ),
                ),
              ),
              _getIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
