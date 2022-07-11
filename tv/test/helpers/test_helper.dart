import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tv/tv.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelperTv,
  GetNowPlayingTv,
  GetPopularTv,
  GetTopRatedTv,
  GetTvRecommendations,
  GetTvDetail,
  GetWatchlistTv,
  GetWatchlistTvStatus,
  RemoveTvWatchlist,
  SaveTvWatchlist,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

// ..E = Event
// ..S = State

//Now playing Tv
class FakeNowPlayingTvE extends Fake implements TvEvent {}

class FakeNowPlayingTvS extends Fake implements TvState {}

class FakeNowPlayingTvBloc extends MockBloc<TvEvent, TvState>
    implements NowPlayingTvBloc {}

//Popular Tv
class FakePopularTvE extends Fake implements TvEvent {}

class FakePopularTvS extends Fake implements TvState {}

class FakePopularTvBloc extends MockBloc<TvEvent, TvState>
    implements PopularTvBloc {}

//Top rated Tv
class FakeTopRatedTvE extends Fake implements TvEvent {}

class FakeTopRatedTvS extends Fake implements TvState {}

class FakeTopRatedTvBloc extends MockBloc<TvEvent, TvState>
    implements TopRatedTvBloc {}

//Detail Tv
class FakeDetailTvE extends Fake implements TvEvent {}

class FakeDetailTvS extends Fake implements TvState {}

class FakeDetailTvBloc extends MockBloc<TvEvent, TvState>
    implements DetailTvBloc {}

//Recommendation Tv
class FakeRecommendationTvE extends Fake implements TvEvent {}

class FakeRecommendationTvS extends Fake implements TvState {}

class FakeRecommendationTvBloc extends MockBloc<TvEvent, TvState>
    implements RecommendationTvBloc {}

//Watchlist Tv
class FakeWatchlistTvE extends Fake implements TvEvent {}

class FakeWatchlistTvS extends Fake implements TvState {}

class FakeWatchlistTvBloc extends MockBloc<TvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}
