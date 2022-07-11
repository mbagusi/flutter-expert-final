import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy/dummy_tv_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeNowPlayingTvBloc fakeNowPlayingTvBloc;
  late FakePopularTvBloc fakePopularTvBloc;
  late FakeTopRatedTvBloc fakeTopRatedTvBloc;

  setUp(() {
    fakeNowPlayingTvBloc = FakeNowPlayingTvBloc();
    registerFallbackValue(FakeNowPlayingTvE());
    registerFallbackValue(FakeNowPlayingTvS());
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvE());
    registerFallbackValue(FakePopularTvS());
    fakeTopRatedTvBloc = FakeTopRatedTvBloc();
    registerFallbackValue(FakeTopRatedTvE());
    registerFallbackValue(FakeTopRatedTvS());
  });

  tearDown(() {
    fakeNowPlayingTvBloc.close();
    fakePopularTvBloc.close();
    fakeTopRatedTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvBloc>(
          create: (context) => fakeNowPlayingTvBloc,
        ),
        BlocProvider<PopularTvBloc>(
          create: (context) => fakePopularTvBloc,
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (context) => fakeTopRatedTvBloc,
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets(
      'page should display listview of [Now Playing Movie, Popular Movie, Top Rated Movie] when HasData state is happen',
      (WidgetTester tester) async {
    when(() => fakeNowPlayingTvBloc.state)
        .thenReturn(NowPlayingTvHasData(tvTestList));
    when(() => fakePopularTvBloc.state)
        .thenReturn(PopularTvHasData(tvTestList));
    when(() => fakeTopRatedTvBloc.state)
        .thenReturn(TopRatedTvHasData(tvTestList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeTvPage()));

    expect(listViewFinder, findsWidgets);
  });
}
