part of 'tv_bloc.dart';

abstract class TvState extends Equatable {
  const TvState();

  @override
  List<Object> get props => [];
}

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object?> get props => [];
}

//Now playing TV series state
class NowPlayingTvEmpty extends TvState {}

class NowPlayingTvLoading extends TvState {}

class NowPlayingTvError extends TvState {
  final String message;

  const NowPlayingTvError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvHasData extends TvState {
  final List<Tv> resultNowPlayingTv;

  const NowPlayingTvHasData(this.resultNowPlayingTv);

  @override
  List<Object> get props => [resultNowPlayingTv];
}

//Popular TV series state
class PopularTvEmpty extends TvState {}

class PopularTvLoading extends TvState {}

class PopularTvError extends TvState {
  final String message;

  const PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvHasData extends TvState {
  final List<Tv> resultPopularTv;

  const PopularTvHasData(this.resultPopularTv);

  @override
  List<Object> get props => [resultPopularTv];
}

//Top rated TV series state
class TopRatedTvEmpty extends TvState {}

class TopRatedTvLoading extends TvState {}

class TopRatedTvError extends TvState {
  final String message;

  const TopRatedTvError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvHasData extends TvState {
  final List<Tv> resultTopRatedTv;

  const TopRatedTvHasData(this.resultTopRatedTv);

  @override
  List<Object> get props => [resultTopRatedTv];
}

//Detail TV series state
class TvDetailEmpty extends TvState {}

class TvDetailLoading extends TvState {}

class TvDetailError extends TvState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvState {
  final TvDetail tvDetail;

  const TvDetailHasData(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

//Watchlist TV series state
class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  final String message;

  const WatchlistTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchlistTvHasStatus extends WatchlistTvState {
  final bool result;

  const WatchlistTvHasStatus(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchlistTvHasMessage extends WatchlistTvState {
  final String message;

  const WatchlistTvHasMessage(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasList extends WatchlistTvState {
  final List<Tv> tv;

  const WatchlistTvHasList(this.tv);

  @override
  List<Object?> get props => [tv];
}

//Recommendation TV series state
class TvRecomEmpty extends TvState {}

class TvRecomLoading extends TvState {}

class TvRecomError extends TvState {
  final String message;

  const TvRecomError(this.message);

  @override
  List<Object> get props => [message];
}

class TvRecomHasData extends TvState {
  final List<Tv> tv;

  const TvRecomHasData(this.tv);

  @override
  List<Object> get props => [tv];
}
