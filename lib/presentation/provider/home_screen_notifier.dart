import 'package:flutter/material.dart';
import 'package:movie_propnext/presentation/pages/home_screen.dart';
import 'package:movie_propnext/presentation/pages/movies/home_movie_page.dart';
import 'package:movie_propnext/presentation/pages/tv/home_tv_page.dart';

class HomeScreenNotifier extends ChangeNotifier {
  int _currentTab = 0;

  List<Widget> screen = [
    HomeScreen(),
    HomeMoviePage(),
    HomeTelevisionPage(),
  ];

  set currentTab(int index) {
    _currentTab = index;
    notifyListeners();
  }

  int get currentTab => _currentTab;
  get currentScreen => screen[_currentTab];
}
