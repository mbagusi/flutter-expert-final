import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';

part 'movie_event.dart';
part 'movie_state.dart';

//Now playing movie
class NowPlayingMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetNowPlayingMovie _getNowPlayingMovie;

  NowPlayingMovieBloc(this._getNowPlayingMovie)
      : super(NowPlayingMovieEmpty()) {
    on<NowPlayingMovie>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _getNowPlayingMovie.execute();

      result.fold((failure) => emit(NowPlayingMovieError(failure.message)),
          (result) => emit(NowPlayingMovieHasData(result)));
    });
  }
}

//Popular movie
class PopularMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPopularMovie _getPopularMovie;

  PopularMovieBloc(this._getPopularMovie) : super(PopularMovieEmpty()) {
    on<PopularMovie>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _getPopularMovie.execute();

      result.fold((failure) => emit(PopularMovieError(failure.message)),
          (result) => emit(PopularMovieHasData(result)));
    });
  }
}

//Top rated movie
class TopRatedMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetTopRatedMovie _getTopRatedMovie;

  TopRatedMovieBloc(this._getTopRatedMovie) : super(TopRatedMovieEmpty()) {
    on<TopRatedMovie>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovie.execute();

      result.fold((failure) => emit(TopRatedMovieError(failure.message)),
          (result) => emit(TopRatedMovieHasData(result)));
    });
  }
}

//Detail movie
class DetailMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(MovieDetailEmpty()) {
    on<DetailMovie>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final result = await _getMovieDetail.execute(id);

      result.fold((failure) => emit(MovieDetailError(failure.message)),
          (result) => emit(MovieDetailHasData(result)));
    });
  }
}

//Watchlist movie
class WatchlistMovieBloc extends Bloc<MovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlist removeWatchlist;
  final SaveWatchlist saveWatchlist;

  WatchlistMovieBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.removeWatchlist,
    required this.saveWatchlist,
  }) : super(WatchlistMovieEmpty()) {
    on<WatchlistMovieList>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (data) {
        emit(WatchlistMovieHasList(data));
      });
    });

    on<WatchlistStatus>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchListStatus.execute(event.id);

      emit(WatchlistMovieHasStatus(result));
    });

    on<AddWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;
      final result = await saveWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(WatchlistMovieHasMessage(message));
      });
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final movie = event.movieDetail;

      final result = await removeWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (message) {
        emit(WatchlistMovieHasMessage(message));
      });
    });
  }
}

//Recommendation movie
class RecommendationMovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieRecommendations _getMovieRecommendations;

  RecommendationMovieBloc(this._getMovieRecommendations)
      : super(MovieRecomEmpty()) {
    on<RecommendationMovie>((event, emit) async {
      final id = event.id;

      emit(MovieRecomLoading());

      final result = await _getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(MovieRecomError(failure.message));
      }, (data) {
        emit(MovieRecomHasData(data));
      });
    });
  }
}
