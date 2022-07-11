import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:tv/tv.dart';

part 'search_event.dart';
part 'search_state.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class MovieSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovie _searchMovies;

  MovieSearchBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchHasMovieData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

class TvSearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTv _searchTv;

  TvSearchBloc(this._searchTv) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(SearchLoading());
        final result = await _searchTv.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchHasTvData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}
