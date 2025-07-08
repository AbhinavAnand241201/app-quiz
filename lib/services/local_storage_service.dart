import 'dart:convert';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service class for handling local data storage using SharedPreferences.
class LocalStorageService {
  static const String _historyKey = 'quiz_history';

  /// Saves a completed quiz attempt to the device's local storage.
  /// The new quiz is added to the beginning of the history list.
  static Future<void> saveAttemptedQuiz(AttemptedQuiz quiz) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getAttemptedQuizzes();
    history.insert(0, quiz); // Add new quiz to the top of the list
    final List<String> historyJson =
        history.map((q) => jsonEncode(q.toJson())).toList();
    await prefs.setStringList(_historyKey, historyJson);
  }

  /// Retrieves the list of all attempted quizzes from local storage.
  /// Returns an empty list if no history is found.
  static Future<List<AttemptedQuiz>> getAttemptedQuizzes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? historyJson = prefs.getStringList(_historyKey);
    if (historyJson == null) {
      return [];
    }
    return historyJson
        .map((q) => AttemptedQuiz.fromJson(jsonDecode(q)))
        .toList();
  }
}
