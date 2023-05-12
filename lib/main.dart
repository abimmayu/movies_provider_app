import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_propnext/common/constant.dart';
import 'package:movie_propnext/common/utils.dart';
import 'package:movie_propnext/presentation/pages/first_page.dart';
import 'package:movie_propnext/presentation/pages/home_screen.dart';
import 'package:movie_propnext/presentation/pages/movies/home_movie_page.dart';
import 'package:movie_propnext/presentation/pages/movies/movie_detail_page.dart';
import 'package:movie_propnext/presentation/pages/movies/popular_movies_page.dart';
import 'package:movie_propnext/presentation/pages/movies/search_page.dart';
import 'package:movie_propnext/presentation/pages/movies/top_rated_movies_page.dart';
import 'package:movie_propnext/presentation/pages/tv/home_tv_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_detail_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_popular_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_search_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_top_rated.dart';
import 'package:movie_propnext/presentation/provider/home_screen_notifier.dart';
import 'package:movie_propnext/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:movie_propnext/presentation/provider/movie/movie_list_notifier.dart';
import 'package:movie_propnext/presentation/provider/movie/movie_search_notifier.dart';
import 'package:movie_propnext/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:movie_propnext/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:movie_propnext/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:movie_propnext/presentation/provider/tv/tv_list_notifier.dart';
import 'package:movie_propnext/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:movie_propnext/presentation/provider/tv/tv_search_notifier.dart';
import 'package:movie_propnext/presentation/provider/tv/tv_top_rated_notifier.dart';
import 'package:provider/provider.dart';
import 'package:movie_propnext/common/injections.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<HomeScreenNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        debugShowCheckedModeBanner: false,
        home: const FirstPage(),
        navigatorObservers: [
          routeObserver,
        ],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeScreen.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case HomeTelevisionPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTelevisionPage());
            case PopularTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => PopularTelevisionPage());
            case TopRatedTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => TopRatedTelevisionPage());
            case TelevisionDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TelevisionDetailPage(id: id),
                settings: settings,
              );
            case SearchTelevisionPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTelevisionPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
