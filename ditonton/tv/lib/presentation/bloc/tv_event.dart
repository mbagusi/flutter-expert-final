part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();
}

//Now playing TV series
class NowPlayingTv extends TvEvent {
  @override
  List<Object> get props => [];
}

//Popular TV series
class PopularTv extends TvEvent {
  @override
  List<Object> get props => [];
}

//Top rated TV series
class TopRatedTv extends TvEvent {
  @override
  List<Object> get props => [];
}

//Detail TV series
class DetailTv extends TvEvent {
  final int id;

  const DetailTv(this.id);

  @override
  List<Object> get props => [id];
}

//Watchlist TV series list
class WatchlistTvList extends TvEvent {
  @override
  List<Object> get props => [];
}

//Watchlist TV series status
class WatchlistStatusTv extends TvEvent {
  final int id;

  const WatchlistStatusTv(this.id);

  @override
  List<Object> get props => [id];
}

//Remove TV series movie
class RemoveWatchlistTv extends TvEvent {
  final TvDetail tvDetail;

  const RemoveWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

//Add watchlist TV series
class AddWatchlistTv extends TvEvent {
  final TvDetail tvDetail;

  const AddWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

//Recommendation TV series
class RecommendationTv extends TvEvent {
  final int id;

  const RecommendationTv(this.id);
  @override
  List<Object> get props => [id];
}
