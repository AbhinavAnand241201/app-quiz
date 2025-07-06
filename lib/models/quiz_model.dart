import 'package:flutter/material.dart';

// ... Quiz and LeaderboardUser models remain the same ...
class Quiz {
  final String title;
  final String subject;
  final String description;
  final Color color;
  final IconData icon;
  final List<Question> questions;
  final String topic;

  Quiz({
    required this.title,
    required this.subject,
    required this.description,
    required this.color,
    required this.icon,
    required this.questions,
    required this.topic,
  });
}

class LeaderboardUser {
  final String name;
  final int score;
  final String avatarUrl;

  LeaderboardUser({
    required this.name,
    required this.score,
    required this.avatarUrl,
  });
}


/// Represents a single question within a [Quiz].
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  // ADDED: Explanation for the Test Analysis screen.
  final String explanation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });
}

/// ADDED: Represents a single page of lesson content.
class Lesson {
  final String title;
  final String content;
  final String emoji;

  Lesson({
    required this.title,
    required this.content,
    required this.emoji,
  });
}

/// ADDED: A model to track a user's answer for the analysis screen.
class UserAnswer {
  final Question question;
  final int selectedAnswerIndex;

  UserAnswer({
    required this.question,
    required this.selectedAnswerIndex,
  });

  bool get isCorrect => selectedAnswerIndex == question.correctAnswerIndex;
}
