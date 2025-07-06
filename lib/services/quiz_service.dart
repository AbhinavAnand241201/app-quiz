import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/models/quiz_model.dart';

class QuizService {
  static List<Quiz>? _quizzes;
  // ADDED: A map to cache the loaded lessons.
  static Map<String, List<Lesson>>? _lessons;

  static List<Quiz> get quizzes => _quizzes ?? [];
  static Map<String, List<Lesson>> get lessons => _lessons ?? {};

  static Future<void> loadAllData() async {
    await _loadQuizzes();
    await _loadLessons();
  }

  static Future<void> _loadQuizzes() async {
    if (_quizzes != null) return;
    final jsonString = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _quizzes = jsonList.map((json) {
      var questionsList = (json['questions'] as List)
          .map((q) => Question(
                questionText: q['questionText'],
                options: List<String>.from(q['options']),
                correctAnswerIndex: q['correctAnswerIndex'],
                // ADDED: Loading the explanation.
                explanation: q['explanation'] ?? 'No explanation available.',
              ))
          .toList();
      return Quiz(
        title: '${json['subject']} Quiz',
        subject: json['subject'],
        topic: json['topic'],
        color: _colorFromHex(json['color']),
        icon: _iconFromName(json['icon']),
        description: json['description'],
        questions: questionsList,
      );
    }).toList();
  }

  // ADDED: A new method to load lessons from JSON.
  static Future<void> _loadLessons() async {
    if (_lessons != null) return;
    final jsonString = await rootBundle.loadString('assets/lessons.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _lessons = jsonMap.map((subject, lessonList) {
      final lessons = (lessonList as List)
          .map((l) => Lesson(
                title: l['title'],
                content: l['content'],
                emoji: l['emoji'],
              ))
          .toList();
      return MapEntry(subject, lessons);
    });
  }

  // Helper methods remain the same
  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static IconData _iconFromName(String iconName) {
    switch (iconName) {
      case 'calculate': return Icons.calculate_rounded;
      case 'pets': return Icons.pets;
      case 'color_lens': return Icons.color_lens;
      case 'account_balance': return Icons.account_balance;
      case 'music_note': return Icons.music_note;
      case 'public': return Icons.public;
      default: return Icons.help_outline;
    }
  }
}
