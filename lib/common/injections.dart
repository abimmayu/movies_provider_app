import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_propnext/data/datasources/db/database_helper.dart';
import 'package:movie_propnext/data/datasources/movie_local_data_source.dart';
import 'package:movie_propnext/data/datasources/movie_remote_data_source.dart';
import 'package:movie_propnext/data/datasources/tv_local_datasource.dart';
import 'package:movie_propnext/data/datasources/tv_remote_datasource.dart';
import 'package:movie_propnext/data/repositories/movie_repository_impl.dart';
import 'package:movie_propnext/data/repositories/tv_repository.dart';
import 'package:movie_propnext/domain/repositories/movie_repositories.dart';
import 'package:movie_propnext/domain/repositories/tv_repositories.dart';
import 'package:movie_propnext/domain/usecases/movie/get_movie_detail.dart';
import 'package:movie_propnext/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:movie_propnext/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:movie_propnext/domain/usecases/movie/get_popular_movies.dart';
import 'package:movie_propnext/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:movie_propnext/domain/usecases/movie/search_movies.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_detail.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_now_playing.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_popular.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:movie_propnext/domain/usecases/tv/get_tv_top_rate.dart';
import 'package:movie_propnext/domain/usecases/tv/search_tv.dart';
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

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => HomeScreenNotifier(),
  );
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvListNotifier(
      getNowPlayingTv: locator(),
      getPopularTv: locator(),
      getTopRatedTv: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailNotifier(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      searchTv: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvNotifier(
      getTopRatedTv: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TelevisionRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TelevisionLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelpertv: locator()));

  // helper
  locator
      .registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}
