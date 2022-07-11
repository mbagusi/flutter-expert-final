// ignore_for_file: constant_identifier_names

import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistMovieBloc>().add(
            WatchlistMovieList(),
          ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(
          WatchlistMovieList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('watchlist movie page'),
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchlistMovieLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMovieError) {
              return Center(
                child: Text(
                  state.message,
                  key: const Key('error_message'),
                ),
              );
            } else if (state is WatchlistMovieHasList) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movie[index];
                  return MovieCard(movie);
                },
                itemCount: state.movie.length,
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
