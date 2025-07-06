
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mock_data.dart';
import '../models/quiz_model.dart';
import '../theme/app_colors.dart';

/// The Leaderboard screen, displaying player rankings.
/// This file has been updated to precisely match the design specification.
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure there's enough data for the podium.
    final topThree = MockData.leaderboard.length >= 3
        ? MockData.leaderboard.take(3).toList()
        : MockData.leaderboard;
    final rest = MockData.leaderboard.length > 3
        ? MockData.leaderboard.skip(3).toList()
        : <LeaderboardUser>[];

    return Scaffold(
      // FIX: Changed background to the correct solid color from the design spec.
      backgroundColor: AppColors.leaderboardBackground,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // FIX: Replaced AppBar with a simple Text header as per the spec.
            Text(
              'Leaderboard',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // FIX: Re-implemented the podium using a Stack for proper layering.
            _PodiumSection(users: topThree),
            const SizedBox(height: 20),
            // The list of other players.
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: rest.length,
                itemBuilder: (context, index) {
                  return _LeaderboardListItem(
                    user: rest[index],
                    rank: index + 4,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// The top section of the leaderboard, showing the top 3 players.
class _PodiumSection extends StatelessWidget {
  final List<LeaderboardUser> users;
  const _PodiumSection({required this.users});

  @override
  Widget build(BuildContext context) {
    // Using a Stack to place the player cards over the trophy icon.
    return Stack(
      alignment: Alignment.center,
      children: [
        // Trophy icon as a background element.
        Icon(
          Icons.emoji_events,
          color: AppColors.podiumYellow.withOpacity(0.3),
          size: 200,
        ),
        // Row containing the top 3 player cards.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (users.length > 1)
              _PodiumPlayerCard(user: users[1], rank: 2),
            if (users.isNotEmpty)
              _PodiumPlayerCard(user: users[0], rank: 1),
            if (users.length > 2)
              _PodiumPlayerCard(user: users[2], rank: 3),
          ],
        ),
      ],
    );
  }
}

/// A card for displaying a player on the podium.
class _PodiumPlayerCard extends StatelessWidget {
  final LeaderboardUser user;
  final int rank;

  const _PodiumPlayerCard({required this.user, required this.rank});

  @override
  Widget build(BuildContext context) {
    final bool isFirstPlace = rank == 1;
    // FIX: Using the correct podium colors from the design spec.
    final Color cardColor = switch (rank) {
      1 => AppColors.podiumYellow,
      2 => AppColors.podiumBlue,
      3 => AppColors.podiumPink,
      _ => Colors.grey,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          // Crown for the 1st place winner.
          if (isFirstPlace)
            const Text('👑', style: TextStyle(fontSize: 30)),
          if (!isFirstPlace) const SizedBox(height: 30), // Placeholder for alignment
          // Player avatar.
          CircleAvatar(
            radius: isFirstPlace ? 35 : 30,
            backgroundImage: NetworkImage(user.avatarUrl),
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 8),
          // Container for the player's name and score.
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  user.name,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
                Text(
                  '${user.score} pts',
                  style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.9), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A list item for players ranked below the podium.
class _LeaderboardListItem extends StatelessWidget {
  final LeaderboardUser user;
  final int rank;

  const _LeaderboardListItem({required this.user, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Rank number.
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // FIX: Changed text color to be readable on dark BG.
                  color: AppColors.textSlightlyDim),
            ),
          ),
          const SizedBox(width: 16),
          // Player avatar.
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
            radius: 25,
          ),
          const SizedBox(width: 16),
          // Player name.
          Expanded(
            child: Text(
              user.name,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  // FIX: Changed text color to be readable on dark BG.
                  color: AppColors.textOnDark),
            ),
          ),
          // Player score.
          Text(
            '${user.score} pts',
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // FIX: Changed text color to be readable on dark BG.
                color: AppColors.textOnDark),
          ),
        ],
      ),
    );
  }
}
