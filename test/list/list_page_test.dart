import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:driveme/list/list_page.dart';

import '../database/test_data_provider.dart';
import '../database/test_data_provider_error.dart';

void main() {
  testWidgets(
      "Cars are displayed with summary details, and selected car is highlighted green.",
      (WidgetTester tester) async {
    final listBloc = ListBloc();
    listBloc.injectDataProviderForTest(TestDataProvider());

    CarsList cars = await TestDataProvider().loadCars();
    cars.items.sort(listBloc.alphabetiseItemsByTitleIgnoreCases);

    await tester.pumpWidget(ListPageWrapper());
    await tester.pump(Duration.zero);

    final carListKey = find.byKey(Key('car_list'));
    expect(carListKey, findsOneWidget);

    _verifyAllCarDetails(cars.items, tester);

    listBloc.selectItem(1);

    WidgetPredicate widgetSelectedPredicate = (Widget widget) =>
        widget is Container &&
        widget.decoration == BoxDecoration(color: Colors.green.shade200);
    WidgetPredicate widgetUnselectedPredicate = (Widget widget) =>
        widget is Container &&
        widget.decoration == BoxDecoration(color: Colors.white);

    expect(find.byWidgetPredicate(widgetSelectedPredicate), findsOneWidget);
    expect(find.byWidgetPredicate(widgetUnselectedPredicate), findsNWidgets(5));
  });

  testWidgets('Proper error message is shown when an error occured',
      (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestDataProviderError());

    await tester.pumpWidget(ListPageWrapper());
    await tester.pump(Duration.zero);

    final errorFinder = find.text("Error: " + ERROR_MESSAGE);
    expect(errorFinder, findsOneWidget);
  });

  testWidgets(
      'After encountering an error, and stream is updated, Widget is also updated.',
      (WidgetTester tester) async {
    ListBloc().injectDataProviderForTest(TestDataProviderError());

    await tester.pumpWidget(ListPageWrapper());
    await tester.pump(Duration.zero);

    final errorFinder = find.text("Error: " + ERROR_MESSAGE);
    expect(errorFinder, findsOneWidget);

    ListBloc().injectDataProviderForTest(TestNewDataProvider());
    await ListBloc().loadItems();

    await tester.pump(Duration.zero);

    CarsList cars = await TestNewDataProvider().loadCars();

    _verifyAllCarDetails(cars.items, tester);
  });
}

void _verifyAllCarDetails(List<Car> carsList, WidgetTester tester) async {
  for (var car in carsList) {
    final carTitleFinder = find.text(car.title);
    final carPricePerDayFinder = find.text("${car.pricePerDay}/day");
    await tester.ensureVisible(carTitleFinder);
    expect(carTitleFinder, findsOneWidget);
    await tester.ensureVisible(carPricePerDayFinder);
    expect(carPricePerDayFinder, findsOneWidget);
  }
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
