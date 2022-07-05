import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:Tv/presentation/bloc/Tv_bloc.dart';
import 'package:Tv/presentation/pages/popular_Tv_page.dart';

import '../../dummy/dummy_Tv_objects.dart';
import '../../helpers/test_helper.dart';

void main() {
  late FakePopularTvBloc fakePopularTvBloc;

  setUp(() {
    fakePopularTvBloc = FakePopularTvBloc();
    registerFallbackValue(FakePopularTvE());
    registerFallbackValue(FakePopularTv());
  });

  tearDown(() {
    fakePopularTvBloc.close();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (_) => fakePopularTvBloc,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('Should display circular progress indicator when loading',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state).thenReturn(PopularTvLoading());

    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const PopularTvPage()));
    await tester.pump();

    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets(
      'Should display AppBar, ListView, TvCardList, and PopularTvPage when data fetched successfully',
      (WidgetTester tester) async {
    when(() => fakePopularTvBloc.state)
        .thenReturn(PopularTvHasData(TvTestList));
    await tester.pumpWidget(_createTestableWidget(const PopularTvPage()));
    await tester.pump();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(TvCardList), findsOneWidget);
    expect(find.byKey(const Key('Popular TV series page')), findsOneWidget);
  });
}
