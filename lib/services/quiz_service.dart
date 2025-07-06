import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/models/quiz_model.dart';

/// A service class responsible for loading quiz data from the JSON asset.
class QuizService {
  // This remains private to prevent outside modification.
  static List<Quiz>? _quizzes;

  // FIX: Added a public getter to safely access the loaded quizzes.
  // Other parts of the app will use this getter.
  static List<Quiz> get quizzes => _quizzes ?? [];

  /// A helper function to parse a hex color string from JSON into a Color object.
  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  /// A helper function to parse an icon name string from JSON into an IconData object.
  static IconData _iconFromName(String iconName) {
    switch (iconName) {
      case 'calculate':
        return Icons.calculate_rounded;
      case 'pets':
        return Icons.pets;
      case 'color_lens':
        return Icons.color_lens;
      case 'account_balance':
        return Icons.account_balance;
      case 'music_note':
        return Icons.music_note;
      case 'public':
        return Icons.public;
      default:
        return Icons.help_outline;
    }
  }

  /// Loads and parses the quiz data from the JSON asset file.
  /// Caches the result to avoid reloading on subsequent calls.
  static Future<void> loadQuizzes() async {
    if (_quizzes != null) {
      return;
    }

    final jsonString = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    _quizzes = jsonList.map((json) {
      var questionsList = (json['questions'] as List)
          .map((q) => Question(
                questionText: q['questionText'],
                options: List<String>.from(q['options']),
                correctAnswerIndex: q['correctAnswerIndex'],
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
}






