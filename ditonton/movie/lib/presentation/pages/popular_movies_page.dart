// ignore_for_file: constant_identifier_names

import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/bloc/movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularMovieBloc>().add(
            PopularMovie(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Popular movie page'),
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, MovieState>(
            builder: (context, state) {
          if (state is PopularMovieLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularMovieHasData) {
            final result = state.resultPopularMovie;
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
