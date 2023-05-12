import 'package:flutter/foundation.dart';
import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/entities/movies/movie.dart';
import 'package:movie_propnext/domain/entities/movies/movie_detail.dart';
import 'package:movie_propnext/domain/usecases/movie/get_movie_detail.dart';
import 'package:movie_propnext/domain/usecases/movie/get_movie_recommendations.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
  });

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  requestState _movieState = requestState.Empty;
  requestState get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  requestState _recommendationState = requestState.Empty;
  requestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = requestState.Loading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = requestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = requestState.Loading;
        _movie = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = requestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = requestState.Loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = requestState.Loaded;
        notifyListeners();
      },
    );
  }
}
