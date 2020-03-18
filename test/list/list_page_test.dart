import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:driveme/list/list_page.dart';

import '../database/test_data_provider.dart';
import '../database/test_data_provider_error.dart';

CarsList cars;

void main() {
  testWidgets("Cars are displayed", (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestDataProvider());

    cars = await TestDataProvider().loadCars();
    cars.items.sort(ListBloc().alphabetiseItemsByTitleIgnoreCases);

    await tester.pumpWidget(ListPageWrapper());
    await tester.pump(Duration.zero);

    final carListKey = find.byKey(Key('car_list'));
    expect(carListKey, findsOneWidget);

    for (var car in cars.items) {
      final carTitleFinder = find.text(car.title);
      final carPricePerDayFinder = find.text("${car.pricePerDay}/day");
      await tester.ensureVisible(carTitleFinder);
      expect(carTitleFinder, findsOneWidget);
      await tester.ensureVisible(carPricePerDayFinder);
      expect(carPricePerDayFinder, findsOneWidget);
    }

    // WidgetPredicate widgetSelectedPredicate = (Widget widget) =>
    //     widget is Container &&
    //     widget.decoration == BoxDecoration(color: Colors.green.shade200);
    // WidgetPredicate widgetUnselectedPredicate = (Widget widget) =>
    //     widget is Container &&
    //     widget.decoration == BoxDecoration(color: Colors.white);

    // expect(find.byWidgetPredicate(widgetSelectedPredicate), findsOneWidget);
    // expect(find.byWidgetPredicate(widgetUnselectedPredicate), findsNWidgets(2));
  });

  testWidgets('Error message is displayed when server error',
      (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestDataProviderError());

    await tester.pumpWidget(ListPageWrapper());

    await tester.pump(Duration.zero);

    final errorFinder = find.text("Error: " + ERROR_MESSAGE);

    expect(errorFinder, findsOneWidget);
  });

  testWidgets('Widget is updated when stream is updated',
      (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestDataProviderError());

    await tester.pumpWidget(ListPageWrapper());

    await tester.pump(Duration.zero);

    final errorFinder = find.text("Error: " + ERROR_MESSAGE);

    expect(errorFinder, findsOneWidget);

    ListBloc().injectDataProviderForTest(TestDataProvider());
    await ListBloc().loadItems();

    await tester.pump(Duration.zero);

    final item1Finder = find.text("Toyota Yaris 2013");
    final item2Finder = find.text("Mercedes-Benz 2017");
    final item3Finder = find.text("Hyundai Sonata 2017");

    expect(item1Finder, findsOneWidget);
    expect(item2Finder, findsOneWidget);
    expect(item3Finder, findsOneWidget);
  });
}

class ListPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ListPage(),
    );
  }
}
