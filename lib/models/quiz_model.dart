import 'package:flutter/material.dart';

// ... Quiz, Question, Lesson, and LeaderboardUser models remain the same ...
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

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
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

class UserAnswer {
  final Question question;
  final int selectedAnswerIndex;

  UserAnswer({
    required this.question,
    required this.selectedAnswerIndex,
  });

  bool get isCorrect => selectedAnswerIndex == question.correctAnswerIndex;
}


/// ADDED: A model to represent a quiz attempt for local storage.
class AttemptedQuiz {
  final String subject;
  final int score;
  final int totalQuestions;
  final DateTime date;

  AttemptedQuiz({
    required this.subject,
    required this.score,
    required this.totalQuestions,
    required this.date,
  });

  // Methods to convert to and from JSON for storage
  Map<String, dynamic> toJson() => {
        'subject': subject,
        'score': score,
        'totalQuestions': totalQuestions,
        'date': date.toIso8601String(),
      };

  factory AttemptedQuiz.fromJson(Map<String, dynamic> json) => AttemptedQuiz(
        subject: json['subject'],
        score: json['score'],
        totalQuestions: json['totalQuestions'],
        date: DateTime.parse(json['date']),
      );
}
