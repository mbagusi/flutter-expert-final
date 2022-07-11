// ignore_for_file: constant_identifier_names

import 'package:core/presentation/widgets/tv_card_list.dart' show TvCardList;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  const PopularTvPage({Key? key}) : super(key: key);

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularTvBloc>().add(
            PopularTv(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Popular TV series page'),
      appBar: AppBar(
        title: const Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, TvState>(
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvHasData) {
              final result = state.resultPopularTv;
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
