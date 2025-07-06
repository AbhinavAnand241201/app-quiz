import 'package:flutter/material.dart';

/// Represents a single quiz with all its associated data.
class Quiz {
  /// The main title of the quiz, e.g., "Math Quiz".
  final String title;

  /// The broader subject category, e.g., "Math".
  final String subject;

  /// A short, engaging description of the quiz.
  final String description;

  /// The primary accent color associated with this quiz, used for theming.
  final Color color;

  /// The icon representing the quiz subject.
  final IconData icon;

  /// A list of [Question] objects that make up the quiz.
  final List<Question> questions;

  /// The specific topic within the subject, e.g., "Algebra".
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

/// Represents a single question within a [Quiz].
class Question {
  /// The text of the question itself.
  final String questionText;

  /// A list of possible answers for the question.
  final List<String> options;

  /// The index of the correct answer in the [options] list.
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

/// Represents a user's entry on the leaderboard.
class LeaderboardUser {
  /// The name of the user.
  final String name;

  /// The user's score.
  final int score;

  /// The URL for the user's avatar image.
  final String avatarUrl;

  LeaderboardUser({
    required this.name,
    required this.score,
    required this.avatarUrl,
  });
}
