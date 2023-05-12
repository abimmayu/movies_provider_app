import 'package:flutter/material.dart';
import 'package:movie_propnext/presentation/provider/home_screen_notifier.dart';
import 'package:movie_propnext/presentation/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    // final selectedIndex = 0;
    final homeScreenProvider = Provider.of<HomeScreenNotifier>(context);
    return Scaffold(
      body: homeScreenProvider.currentScreen,
      bottomNavigationBar: BottomNavBar(
        onTabChanges: (i) {
          homeScreenProvider.currentTab = i;
        },
        currentIndex: homeScreenProvider.currentTab,
      ),
    );
  }
}
