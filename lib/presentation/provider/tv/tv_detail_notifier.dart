import 'package:flutter/foundation.dart';
import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/entities/tv/tv.dart';
import 'package:movie_propnext/domain/entities/tv/tv_detail.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_detail.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_recommendations.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  requestState _tvState = requestState.Empty;
  requestState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;

  requestState _recommendationTvState = requestState.Empty;
  requestState get recommendationTvState => _recommendationTvState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlistTv = false;
  bool get isAddedToWatchlistTv => _isAddedtoWatchlistTv;

  Future<void> fetchTvDetail(int id) async {
    _tvState = requestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = requestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _recommendationTvState = requestState.Loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationTvState = requestState.Error;
            _message = failure.message;
          },
          (tv) {
            _recommendationTvState = requestState.Loaded;
            _tvRecommendations = tv;
          },
        );
        _tvState = requestState.Loaded;
        notifyListeners();
      },
    );
  }
}
