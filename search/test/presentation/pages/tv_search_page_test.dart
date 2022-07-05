import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';
import 'package:Tveries/Tveries.dart';

import '../../helpers/test_helper.dart';

void main() {
  late FaketTvearchBloc faketTvearchBloc;

  setUp(() {
    faketTvearchBloc = FaketTvearchBloc();
    registerFallbackValue(FakeTvearchE());
    registerFallbackValue(FakeTvearchS());
  });

  tearDown(() {
    faketTvearchBloc.close();
  });

  final TvTest = Tv(
      backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
      genreIds: const [18, 9648],
      id: 31917,
      originalName: 'Pretty Little Liars',
      overview:
          // ignore: unnecessary_string_escapes
          'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
      popularity: 47.432451,
      posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
      firstAirDate: '2010-06-08',
      name: 'Pretty Little Liars',
      voteAverage: 5.04,
      voteCount: 133);

  final TvTestList = [TvTest];

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<TvearchBloc>(
      create: (_) => faketTvearchBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => faketTvearchBloc.state).thenReturn(SearchLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TvearchPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'should display AppBar, ListView, MovieCard, and SearchTvPage when data is fetched successfully',
      (WidgetTester tester) async {
    when(() => faketTvearchBloc.state)
        .thenReturn(SearchHasTvData(TvTestList));
    await tester.pumpWidget(_createTestableWidget(const TvearchPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCardList), findsOneWidget);
    expect(find.byKey(const Key('Tv search page')), findsOneWidget);
  });

  testWidgets('should display text with message when error',
      (WidgetTester tester) async {
    const errorMessage = 'error message';

    when(() => faketTvearchBloc.state)
        .thenReturn(const SearchError(errorMessage));

    final textMessageKeyFinder = find.byKey(const Key('error_message'));
    await tester.pumpWidget(_createTestableWidget(const TvearchPage()));
    await tester.pump();

    expect(textMessageKeyFinder, findsOneWidget);
  });
}
