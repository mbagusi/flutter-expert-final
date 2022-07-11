// ignore_for_file: constant_identifier_names

import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistTvPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistTvBloc>().add(
            WatchlistTvList(),
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
    context.read<WatchlistTvBloc>().add(
          WatchlistTvList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('watchlist tv page'),
      appBar: AppBar(
        title: const Text('Watchlist TV series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            if (state is WatchlistTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvError) {
              return Center(
                child: Text(
                  state.message,
                  key: const Key('error_message'),
                ),
              );
            } else if (state is WatchlistTvHasList) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tv[index];
                  return TvCardList(tv);
                },
                itemCount: state.tv.length,
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
