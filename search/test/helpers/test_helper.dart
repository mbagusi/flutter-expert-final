import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';

@GenerateMocks([
  SearchMovie,
  SearchTv,
  MovieRepository,
  TvRepository,
])
void main() {}

// ..E = Event
// ..S = State

// Movie search
class FakeMovieSearchE extends Fake implements SearchEvent {}

class FakeMovieSearchS extends Fake implements SearchState {}

class FakeMovieSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements MovieSearchBloc {}

// Tv search
class FakeTvSearchE extends Fake implements SearchEvent {}

class FakeTvSearchS extends Fake implements SearchState {}

class FaketTvSearchBloc extends MockBloc<SearchEvent, SearchState>
    implements TvSearchBloc {}
