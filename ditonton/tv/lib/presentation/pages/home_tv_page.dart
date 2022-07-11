// ignore_for_file: constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:search/search.dart';
import 'package:tv/tv.dart';
import 'package:about/about.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
  static const ROUTE_NAME = '/tv';
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingTvBloc>(context, listen: false).add(
        NowPlayingTv(),
      );
      BlocProvider.of<PopularTvBloc>(context, listen: false).add(
        PopularTv(),
      );
      BlocProvider.of<TopRatedTvBloc>(context, listen: false).add(
        TopRatedTv(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pushNamed(context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              children: [
                ListTile(
                  leading: const Icon(Icons.movie),
                  title: const Text('Movies'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistMoviesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tv),
                  title: const Text('TV'),
                  onTap: () {
                    Navigator.pushNamed(context, WatchlistTvPage.ROUTE_NAME);
                  },
                ),
              ],
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, TvSearchPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing TV series',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingTvBloc, TvState>(
                  builder: (context, state) {
                if (state is NowPlayingTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvHasData) {
                  final result = state.resultNowPlayingTv;
                  return TvList(result);
                } else if (state is NowPlayingTvError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        key: const Key('error'),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, TvState>(builder: (context, state) {
                if (state is PopularTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvHasData) {
                  final result = state.resultPopularTv;
                  return TvList(result);
                } else if (state is PopularTvError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        key: const Key('error'),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              }),
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TvState>(builder: (context, state) {
                if (state is TopRatedTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvHasData) {
                  final result = state.resultTopRatedTv;
                  return TvList(result);
                } else if (state is TopRatedTvError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        key: const Key('error'),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('Failed'),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  const TvList(this.tv, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv1 = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv1.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv1.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
