import 'package:movie_propnext/common/exception.dart';
import 'package:movie_propnext/data/datasources/db/database_helper.dart';
import 'package:movie_propnext/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(MovieTable movie);
  Future<String> removeWatchlist(MovieTable movie);
  Future<MovieTable?> getMovieById(int id);
  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelperMovie databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}