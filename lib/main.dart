import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/screens/main_screen.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The main app theme is configured here.
    return MaterialApp(
      title: 'hellorabbi Quiz App',
      theme: ThemeData(
        // FIX: The global scaffoldBackgroundColor has been removed.
        // This allows each screen to define its own background color
        // according to the design specification, making the theme flexible.

        // Use Poppins as the default font family.
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        // The color scheme is based on a primary brand color.
        // Brightness is set to light to ensure default text is dark and visible
        // on the app's primary light-themed screens.
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
