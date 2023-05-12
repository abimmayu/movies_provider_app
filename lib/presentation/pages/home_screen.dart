import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/dummy_movie.dart';
import 'package:movie_propnext/domain/entities/movies/movie.dart';
import 'package:movie_propnext/domain/entities/tv/tv.dart';
import 'package:movie_propnext/presentation/pages/movies/movie_detail_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_detail_page.dart';
import 'package:movie_propnext/presentation/provider/movie/movie_list_notifier.dart';
import 'package:movie_propnext/presentation/provider/tv/tv_list_notifier.dart';
import 'package:movie_propnext/presentation/widgets/bottom_navigation_bar.dart';
import 'package:movie_propnext/presentation/widgets/carousel_card.dart';
import 'package:movie_propnext/presentation/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static const ROUTE_NAME = '/home_screen';
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageControllerPopularMovies;
  late PageController _pageControllerPopularTvSeries;
  final int _currentPage = 0;
  final TextEditingController _searchController = TextEditingController();

  String ROUTE_NAME = "/home";

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchPopularMovies(),
    );
    Future.microtask(
      () =>
          Provider.of<TvListNotifier>(context, listen: false)..fetchPopularTv(),
    );
    _pageControllerPopularMovies = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8,
    );
    _pageControllerPopularTvSeries = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageControllerPopularMovies.dispose();
    _pageControllerPopularTvSeries.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black87,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 40,
              ),
              child: Text(
                "Misaflix",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // searchBar(_searchController),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "Popular Movies",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Consumer<MovieListNotifier>(
                      builder: (context, data, child) {
                        final state = data.popularMoviesState;
                        if (state == requestState.Loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state == requestState.Loaded) {
                          return AspectRatio(
                            aspectRatio: 1,
                            child: PageView.builder(
                              itemCount: data.popularMovies.length,
                              controller: _pageControllerPopularMovies,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return carouselView(
                                  index,
                                  _pageControllerPopularMovies,
                                  data.popularMovies,
                                );
                              },
                            ),
                          );
                        } else {
                          return Text('Failed to connect to the network');
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Text(
                        "Popular Tv Series",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Consumer<TvListNotifier>(
                      builder: (context, data, child) {
                        final state = data.popularTvState;
                        if (state == requestState.Loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state == requestState.Loaded) {
                          return AspectRatio(
                            aspectRatio: 1,
                            child: PageView.builder(
                              itemCount: data.popularTv.length,
                              scrollDirection: Axis.horizontal,
                              controller: _pageControllerPopularTvSeries,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return carouselView(
                                  index,
                                  _pageControllerPopularTvSeries,
                                  data.popularTv,
                                );
                              },
                            ),
                          );
                        } else {
                          return Text('Failed to connect to the network');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget carouselView(int index, PageController pageController, dynamic data) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, child) {
        double value = 0.0;
        if (pageController.position.haveDimensions) {
          value = index.toDouble() - (pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: carouselCard(data[index], context),
        );
      },
    );
  }
}
