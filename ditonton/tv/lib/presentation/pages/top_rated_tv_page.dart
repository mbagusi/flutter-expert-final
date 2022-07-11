// ignore_for_file: constant_identifier_names

import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedTvBloc>().add(
            TopRatedTv(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Top rated TV series page'),
      appBar: AppBar(
        title: const Text('Top Rated TV series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TvState>(
          builder: (context, state) {
            if (state is TopRatedTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvHasData) {
              final result = state.resultTopRatedTv;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCardList(tv);
                },
                itemCount: result.length,
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }
}
