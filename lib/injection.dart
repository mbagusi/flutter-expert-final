import 'package:core/utils/ssl.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

final locator = GetIt.instance;

void init() {
  // Movie bloc♦
  locator.registerFactory(
    () => NowPlayingMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      getWatchlistMovies: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationMovieBloc(
      locator(),
    ),
  );

  // TV series bloc
  locator.registerFactory(
    () => NowPlayingTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => DetailTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchBloc(locator()),
  );
  locator.registerFactory(
    () => WatchlistTvBloc(
      getWatchlistTvStatus: locator(),
      getWatchlistTv: locator(),
      removeTvWatchlist: locator(),
      saveTvWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => RecommendationTvBloc(
      locator(),
    ),
  );

  //movie use case
  locator.registerLazySingleton(() => GetNowPlayingMovie(locator()));
  locator.registerLazySingleton(() => GetPopularMovie(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovie(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovie(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  //tv series use case
  locator.registerLazySingleton(() => GetNowPlayingTv(locator()));
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTv(locator()));
  locator.registerLazySingleton(() => Ssl());

  //movie repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  //tv series repository
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // movie data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // tv series data sources
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelperTv: locator()));

  // movie helper
  locator
      .registerLazySingleton<DatabaseHelperMovie>(() => DatabaseHelperMovie());

  //tv series helper
  locator.registerLazySingleton<DatabaseHelperTv>(() => DatabaseHelperTv());

  // external
  locator.registerLazySingleton(() => http.Client());
}
