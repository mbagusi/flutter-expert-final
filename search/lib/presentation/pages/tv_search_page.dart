// ignore_for_file: constant_identifier_names

import 'package:core/core.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_bloc.dart';

class TvSearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search_tv';

  const TvSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Tv search page'),
      appBar: AppBar(
        title: const Text('Search TV series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<TvSearchBloc>().add(
                      OnQueryChanged(query),
                    );
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasTvData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return TvCardList(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return const Text(
                    'Failed',
                    key: Key('error_message'),
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
