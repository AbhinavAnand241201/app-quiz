import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/theme/app_colors.dart';

/// A new screen to display user profile information and performance analytics.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
              value: '12',
              icon: Icons.check_circle,
              color: AppColors.radiantLime),
          const SizedBox(height: 16),
          _StatCard(
              title: 'Average Score',
              value: '82%',
              icon: Icons.star,
              color: AppColors.buttonGold),
          const SizedBox(height: 30),
          _SectionTitle(title: 'Weekly Performance'),
          const SizedBox(height: 16),
          _WeeklyPerformanceChart(),
          const SizedBox(height: 30),
          _SectionTitle(title: 'Subject Mastery'),
          const SizedBox(height: 16),
          _SubjectMasteryChart(),
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
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a042581f4e29026704d'),
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
                style: TextStyle(fontSize: 16, color: AppColors.textSlightlyDim)),
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

class _WeeklyPerformanceChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: [
            _makeBarGroup(0, 5),
            _makeBarGroup(1, 6.5),
            _makeBarGroup(2, 5),
            _makeBarGroup(3, 7.5),
            _makeBarGroup(4, 9),
            _makeBarGroup(5, 11.5),
            _makeBarGroup(6, 6.5),
          ],
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) =>
                    SideTitleWidget(axisSide: meta.axisSide, child: Text(['M', 'T', 'W', 'T', 'F', 'S', 'S'][value.toInt()])),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
          toY: y,
          color: AppColors.challengeBlue,
          width: 22,
          borderRadius: BorderRadius.circular(6))
    ]);
  }
}

class _SubjectMasteryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
                color: AppColors.radiantOrange, value: 40, title: '40%', radius: 50),
            PieChartSectionData(
                color: AppColors.radiantCyan, value: 30, title: '30%', radius: 50),
            PieChartSectionData(
                color: AppColors.radiantPink, value: 15, title: '15%', radius: 50),
            PieChartSectionData(
                color: AppColors.buttonGold, value: 15, title: '15%', radius: 50),
          ],
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }
}
