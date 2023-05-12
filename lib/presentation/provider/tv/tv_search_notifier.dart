import 'package:movie_propnext/common/state_enum.dart';
import 'package:movie_propnext/domain/entities/tv/tv.dart';

import 'package:flutter/foundation.dart';
import 'package:movie_propnext/domain/usecases/tv/search_tv.dart';

class TvSearchNotifier extends ChangeNotifier {
  final SearchTv searchTv;

  TvSearchNotifier({required this.searchTv});

  requestState _state = requestState.Empty;
  requestState get state => _state;

  List<Tv> _searchTvResult = [];
  List<Tv> get searchTvResult => _searchTvResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = requestState.Loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = requestState.Error;
        notifyListeners();
      },
      (data) {
        _searchTvResult = data;
        _state = requestState.Loaded;
        notifyListeners();
      },
    );
  }
}
