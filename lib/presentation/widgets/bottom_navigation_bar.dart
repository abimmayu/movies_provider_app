import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.onTabChanges,
    required this.currentIndex,
  });

  final Function(int) onTabChanges;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        // vertical: 20.0,
      ),
      child: GNav(
        selectedIndex: currentIndex,
        onTabChange: onTabChanges,
        backgroundColor: Colors.black,
        color: Colors.white24,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.white10,
        padding: EdgeInsets.all(16),
        gap: 10,
        tabs: const [
          GButton(
            icon: Icons.home_filled,
            text: "Home",
          ),
          GButton(
            icon: Icons.movie_creation_rounded,
            text: "Movies",
          ),
          GButton(
            icon: Icons.tv_rounded,
            text: "Tv Series",
          ),
        ],
      ),
    );
    ;
  }
}
