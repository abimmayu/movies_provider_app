import 'package:flutter/foundation.dart';
import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/entities/tv/tv.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_now_playing.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_popular.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_top_rate.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingTv = <Tv>[];
  List<Tv> get nowPlayingTv => _nowPlayingTv;

  requestState _nowPlayingTvState = requestState.Empty;
  requestState get nowPlayingTvState => _nowPlayingTvState;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  requestState _popularTvState = requestState.Empty;
  requestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  requestState _topRatedTvState = requestState.Empty;
  requestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetNowPlayingTv getNowPlayingTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchNowPlayingTv() async {
    _nowPlayingTvState = requestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _nowPlayingTvState = requestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _nowPlayingTvState = requestState.Loaded;
        _nowPlayingTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = requestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = requestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = requestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = requestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = requestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvState = requestState.Loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}
