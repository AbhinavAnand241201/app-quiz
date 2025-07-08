import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/theme/app_colors.dart';

class GeminiService {
  // IMPORTANT: In a real-world app, NEVER hardcode your API key like this.
  // This should be stored securely using environment variables or a secrets management service.
  static const String _apiKey = "AIzaSyDb5HAYfC3mRZ0TMNvFDtW1MRZ0xIjoqWU";
  static const String _url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$_apiKey';

  static Future<Quiz> generateQuiz(
      {required String subject,
      required List<String> topics,
      required String difficulty,
      int questionCount = 5}) async {
    final prompt = _buildPrompt(subject, topics, difficulty, questionCount);

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {'Content-Type': 'application/json'},
        // FIX: Corrected the JSON structure. The "parts" value must be a list of objects.
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        return _parseQuizFromResponse(text, subject);
      } else {
        throw Exception('Failed to generate quiz: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error generating quiz: $e');
      return _getFallbackQuiz(subject);
    }
  }

  static String _buildPrompt(String subject, List<String> topics,
      String difficulty, int questionCount) {
    return """
    Generate a $difficulty level quiz about $subject.
    Focus on these topics: ${topics.join(', ')}.
    The quiz should have exactly $questionCount multiple-choice questions.
    Each question must have 4 options and one correct answer.
    Provide an explanation for why the correct answer is right.

    Return the response ONLY as a valid JSON object with the following structure:
    {
      "questions": [
        {
          "questionText": "...",
          "options": ["...", "...", "...", "..."],
          "correctAnswerIndex": ...,
          "explanation": "..."
        }
      ]
    }
    """;
  }

  static Quiz _parseQuizFromResponse(String responseText, String subject) {
    final cleanedJson =
        responseText.replaceAll('```json', '').replaceAll('```', '').trim();
    final json = jsonDecode(cleanedJson);
    final List<dynamic> questionsJson = json['questions'];

    final questions = questionsJson.map((q) {
      return Question(
        questionText: q['questionText'],
        options: List<String>.from(q['options']),
        correctAnswerIndex: q['correctAnswerIndex'],
        explanation: q['explanation'],
      );
    }).toList();

    return Quiz(
      title: '$subject Challenge',
      subject: subject,
      topic: 'Dynamic Quiz',
      description: 'A special quiz generated just for you by Gemini!',
      color: AppColors.challengeBlue,
      icon: Icons.auto_awesome,
      questions: questions,
    );
  }

  static Quiz _getFallbackQuiz(String subject) {
    return Quiz(
      title: 'Error Quiz',
      subject: subject,
      topic: 'Error',
      description:
          'We could not generate a quiz. Please check your connection and API key.',
      color: Colors.red,
      icon: Icons.error_outline,
      questions: [
        Question(
            questionText: 'Something went wrong. Please try again later.',
            options: ['OK', '', '', ''],
            correctAnswerIndex: 0,
            explanation: 'There was an error communicating with the AI.')
      ],
    );
  }
}
