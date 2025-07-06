import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/screens/quiz_question_screen.dart';
import 'package:quiz_app/theme/app_colors.dart';

class LessonScreen extends StatefulWidget {
  final Quiz quiz;
  final List<Lesson> lessons;

  const LessonScreen({super.key, required this.quiz, required this.lessons});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.quiz.color,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.lessons.length,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final lesson = widget.lessons[index];
                return _LessonPage(lesson: lesson);
              },
            ),
          ),
          _NavigationControls(
            currentPage: _currentPage,
            pageCount: widget.lessons.length,
            onNext: () {
              if (_currentPage < widget.lessons.length - 1) {
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              } else {
                // Navigate to the quiz
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizQuestionScreen(quiz: widget.quiz)));
              }
            },
          ),
        ],
      ),
    );
  }
}

class _LessonPage extends StatelessWidget {
  final Lesson lesson;
  const _LessonPage({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(lesson.emoji, style: const TextStyle(fontSize: 100)),
          const SizedBox(height: 20),
          Text(lesson.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 16),
          Text(lesson.content,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 18, color: Colors.white.withOpacity(0.9))),
        ],
      ),
    );
  }
}

class _NavigationControls extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final VoidCallback onNext;

  const _NavigationControls(
      {required this.currentPage,
      required this.pageCount,
      required this.onNext});

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentPage == pageCount - 1;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(pageCount, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: index == currentPage
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.brandDarkBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(isLastPage ? "Start Quiz!" : "Next",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
