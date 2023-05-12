import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/entities/movies/movie.dart';
import 'package:movie_propnext/domain/usecases/movie/get_popular_movies.dart';
import 'package:flutter/foundation.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMovies getPopularMovies;

  PopularMoviesNotifier(this.getPopularMovies);

  requestState _state = requestState.Empty;
  requestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularMovies() async {
    _state = requestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = requestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = requestState.Loaded;
        notifyListeners();
      },
    );
  }
}
