import 'package:flutter/foundation.dart';
import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/entities/tv/tv.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_top_rate.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvNotifier({required this.getTopRatedTv});

  requestState _state = requestState.Empty;
  requestState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = requestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = requestState.Error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = requestState.Loaded;
        notifyListeners();
      },
    );
  }
}
