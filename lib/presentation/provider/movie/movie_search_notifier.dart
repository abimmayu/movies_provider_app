import 'package:flutter/foundation.dart';
import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/entities/movies/movie.dart';
import 'package:movie_propnext/domain/usecases/movie/search_movies.dart';

class MovieSearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  MovieSearchNotifier({required this.searchMovies});

  requestState _state = requestState.Empty;
  requestState get state => _state;

  List<Movie> _searchResult = [];
  List<Movie> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = requestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = requestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = requestState.Loaded;
        notifyListeners();
      },
    );
  }
}
