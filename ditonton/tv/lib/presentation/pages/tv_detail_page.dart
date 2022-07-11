// ignore_for_file: constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailTvBloc>().add(
            DetailTv(widget.id),
          );
      context.read<WatchlistTvBloc>().add(
            WatchlistStatusTv(widget.id),
          );
      context.read<RecommendationTvBloc>().add(
            RecommendationTv(widget.id),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedTvWatchlist = context.select<WatchlistTvBloc, bool>((bloc) {
      if (bloc.state is WatchlistTvHasStatus) {
        return (bloc.state as WatchlistTvHasStatus).result;
      }
      return false;
    });

    return Scaffold(
      key: const Key('tv detail content'),
      body: BlocBuilder<DetailTvBloc, TvState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final result = state.tvDetail;
            return SafeArea(
              child: TvDetailContent(
                result,
                isAddedTvWatchlist,
              ),
            );
          } else if (state is TvDetailError) {
            return Expanded(
              child: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Text('Failed'),
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class TvDetailContent extends StatefulWidget {
  final TvDetail tv;
  late bool isAddedTvWatchlist;

  TvDetailContent(this.tv, this.isAddedTvWatchlist, {Key? key})
      : super(key: key);

  @override
  State<TvDetailContent> createState() => _TvDetailContentState();
}

class _TvDetailContentState extends State<TvDetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isAddedTvWatchlist) {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(AddWatchlistTv(widget.tv));
                                } else {
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(RemoveWatchlistTv(widget.tv));
                                }
                                String message = "";
                                const watchlistAddSuccessMessage =
                                    'Added to Watchlist';
                                const watchlistRemoveSuccessMessage =
                                    'Removed from Watchlist';

                                final state =
                                    BlocProvider.of<WatchlistTvBloc>(context)
                                        .state;

                                if (state is WatchlistTvHasStatus) {
                                  final status = state.result;
                                  message = status == false
                                      ? watchlistAddSuccessMessage
                                      : watchlistRemoveSuccessMessage;
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                                setState(() {
                                  widget.isAddedTvWatchlist =
                                      !widget.isAddedTvWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isAddedTvWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tv.genres),
                            ),
                            Text(
                              widget.tv.firstAirDate,
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvBloc, TvState>(
                              builder: (context, state) {
                                if (state is TvRecomLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvRecomError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else if (state is TvRecomHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.tv[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.tv.length,
                                    ),
                                  );
                                } else if (state is TvRecomEmpty) {
                                  return const Center(
                                    child: Text('No Data.'),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
