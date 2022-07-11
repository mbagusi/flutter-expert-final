// ignore_for_file: constant_identifier_names

import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedMovieBloc>().add(
            TopRatedMovie(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Top rated movie page'),
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, MovieState>(
            builder: (context, state) {
          if (state is TopRatedMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedMovieHasData) {
            final result = state.resultTopRatedMovie;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie);
              },
              itemCount: result.length,
            );
          } else {
            return const Center(
              key: Key('error_message'),
              child: Text('Failed'),
            );
          }
        }),
      ),
    );
  }
}
