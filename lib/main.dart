import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/main_screen.dart';
import 'package:quiz_app/services/quiz_service.dart';
import 'theme/app_colors.dart';

void main() async {
  // Ensure that Flutter bindings are initialized.
  WidgetsFlutterBinding.ensureInitialized();
  // Load the quiz data from JSON before running the app.
  await QuizService.loadQuizzes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hellorabbi Quiz App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.challengeBlue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
