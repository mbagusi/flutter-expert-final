import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movie/movie.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelperMovie,
  GetNowPlayingMovie,
  GetPopularMovie,
  GetTopRatedMovie,
  GetMovieRecommendations,
  GetMovieDetail,
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

// ..E = Event
// ..S = State

//Now playing movie
class FakeNowPlayingMovieE extends Fake implements MovieEvent {}

class FakeNowPlayingMovieS extends Fake implements MovieState {}

class FakeNowPlayingMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements NowPlayingMovieBloc {}

//Popular movie
class FakePopularMovieE extends Fake implements MovieEvent {}

class FakePopularMovieS extends Fake implements MovieState {}

class FakePopularMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements PopularMovieBloc {}

//Top rated movie
class FakeTopRatedMovieE extends Fake implements MovieEvent {}

class FakeTopRatedMovieS extends Fake implements MovieState {}

class FakeTopRatedMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements TopRatedMovieBloc {}

//Detail movie
class FakeDetailMovieE extends Fake implements MovieEvent {}

class FakeDetailMovieS extends Fake implements MovieState {}

class FakeDetailMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements DetailMovieBloc {}

//Recommendation movie
class FakeRecommendationMovieE extends Fake implements MovieEvent {}

class FakeRecommendationMovieS extends Fake implements MovieState {}

class FakeRecommendationMovieBloc extends MockBloc<MovieEvent, MovieState>
    implements RecommendationMovieBloc {}

//Wachlist movie
class FakeWatchlistMovieE extends Fake implements MovieEvent {}

class FakeWatchlistMovieS extends Fake implements WatchlistMovieState {}

class FakeWatchlistMovieBloc extends MockBloc<MovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}
