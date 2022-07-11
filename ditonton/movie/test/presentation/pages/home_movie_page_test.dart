import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../../dummy/dummy_movie_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakeNowPlayingMovieBloc fakeNowPlayingMovieBloc;
  late FakePopularMovieBloc fakePopularMovieBloc;
  late FakeTopRatedMovieBloc fakeTopRatedMovieBloc;

  setUp(() {
    fakeNowPlayingMovieBloc = FakeNowPlayingMovieBloc();
    registerFallbackValue(FakeNowPlayingMovieE());
    registerFallbackValue(FakeNowPlayingMovieS());
    fakePopularMovieBloc = FakePopularMovieBloc();
    registerFallbackValue(FakePopularMovieE());
    registerFallbackValue(FakePopularMovieS());
    fakeTopRatedMovieBloc = FakeTopRatedMovieBloc();
    registerFallbackValue(FakeTopRatedMovieE());
    registerFallbackValue(FakeTopRatedMovieS());
  });

  tearDown(() {
    fakeNowPlayingMovieBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (context) => fakeNowPlayingMovieBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (context) => fakeTopRatedMovieBloc,
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
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsWidgets);
  });
}
