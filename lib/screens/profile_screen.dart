import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/services/local_storage_service.dart';
import 'package:quiz_app/theme/app_colors.dart';

/// The screen for displaying user profile information and performance analytics.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<AttemptedQuiz> _history = [];
  Map<String, double> _subjectAverages = {};
  List<String> _subjectOrder = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await LocalStorageService.getAttemptedQuizzes();
    if (mounted) {
      setState(() {
        _history = history;
        _calculateSubjectAverages();
      });
    }
  }

  String _calculateOverallAverageScore() {
    if (_history.isEmpty) return '0%';
    double totalScore = 0;
    double totalPossibleScore = 0;
    for (var attempt in _history) {
      totalScore += attempt.score;
      totalPossibleScore += attempt.totalQuestions;
    }
    if (totalPossibleScore == 0) return '0%';
    final average = (totalScore / totalPossibleScore) * 100;
    return '${average.toStringAsFixed(0)}%';
  }

  void _calculateSubjectAverages() {
    Map<String, List<int>> subjectScores = {};
    Map<String, List<int>> subjectTotals = {};

    for (var attempt in _history) {
      subjectScores.putIfAbsent(attempt.subject, () => []).add(attempt.score);
      subjectTotals
          .putIfAbsent(attempt.subject, () => [])
          .add(attempt.totalQuestions);
    }

    Map<String, double> averages = {};
    subjectScores.forEach((subject, scores) {
      double totalScore = scores.reduce((a, b) => a + b).toDouble();
      double totalPossible =
          subjectTotals[subject]!.reduce((a, b) => a + b).toDouble();
      averages[subject] = (totalScore / totalPossible) * 100;
    });

    setState(() {
      _subjectAverages = averages;
      _subjectOrder = averages.keys.toList();
    });
  }

  List<BarChartGroupData> _generateChartData() {
    return _subjectOrder.asMap().entries.map((entry) {
      int index = entry.key;
      String subject = entry.value;
      double average = _subjectAverages[subject] ?? 0;
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(
            toY: average,
            color: AppColors.challengeBlue,
            width: 22,
            borderRadius: BorderRadius.circular(6))
      ]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text('My Profile',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: AppColors.brandDarkBlue)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _ProfileHeader(),
          const SizedBox(height: 30),
          _StatCard(
              title: 'Quizzes Completed',
              value: _history.length.toString(),
              icon: Icons.check_circle,
              color: AppColors.radiantLime),
          const SizedBox(height: 16),
          _StatCard(
              title: 'Average Score',
              value: _calculateOverallAverageScore(),
              icon: Icons.star,
              color: AppColors.buttonGold),
          const SizedBox(height: 30),
          _SectionTitle(title: 'Performance by Subject'),
          const SizedBox(height: 16),
          _PerformanceChart(
              chartData: _generateChartData(), subjects: _subjectOrder),
          const SizedBox(height: 30),
          _SectionTitle(title: 'Quiz History'),
          const SizedBox(height: 16),
          _QuizHistoryList(history: _history),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage:
              NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Little Rabbit',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandDarkBlue)),
            Text('Grade 3',
                style:
                    TextStyle(fontSize: 16, color: AppColors.textSlightlyDim)),
          ],
        )
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard(
      {required this.title,
      required this.value,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.brandDarkBlue)),
          const Spacer(),
          Text(value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandDarkBlue)),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.brandDarkBlue));
  }
}

class _PerformanceChart extends StatelessWidget {
  final List<BarChartGroupData> chartData;
  final List<String> subjects;
  const _PerformanceChart({required this.chartData, required this.subjects});

  @override
  Widget build(BuildContext context) {
    if (chartData.isEmpty) {
      return const Center(
          child: Text("Complete some quizzes to see your performance!"));
    }
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: chartData,
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= subjects.length) return const SizedBox();
                  final subject = subjects[value.toInt()];
                  return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(subject.substring(0, 3)));
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }
}

class _QuizHistoryList extends StatelessWidget {
  final List<AttemptedQuiz> history;
  const _QuizHistoryList({required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text('No quizzes attempted yet! Complete a quiz to see your history.'),
      ));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final attempt = history[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.history, color: AppColors.challengeBlue),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(attempt.subject,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.brandDarkBlue)),
                    Text(DateFormat.yMMMd().format(attempt.date),
                        style: const TextStyle(
                            color: AppColors.textSlightlyDim, fontSize: 12)),
                  ],
                ),
              ),
              Text('${attempt.score}/${attempt.totalQuestions}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.brandDarkBlue)),
            ],
          ),
        );
      },
    );
  }
}
