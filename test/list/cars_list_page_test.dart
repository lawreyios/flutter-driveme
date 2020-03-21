import 'package:driveme/dependency_injector.dart';
import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import 'package:driveme/list/cars_list_page.dart';
import 'package:driveme/constants.dart';

import '../database/mock_car_data_provider.dart';
import '../database/mock_car_data_provider_error.dart';

void main() {
  setupLocator();
  var carsListBloc = locator<CarsListBloc>();

  testWidgets(
      "Cars are displayed with summary details, and selected car is highlighted green.",
      (WidgetTester tester) async {
    // TODO 18: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());

    // TODO 19: Load & Sort Mock Data for Verification
    CarsList cars = await MockCarDataProvider().loadCars();
    cars.items.sort(carsListBloc.alphabetiseItemsByTitleIgnoreCases);

    // TODO 20: Load and render Widget
    await tester.pumpWidget(ListPageWrapper());
    await tester.pump(Duration.zero);

    // TODO 21: Check Cars List's component's existence via key
    final carListKey = find.byKey(Key(CARS_LIST_KEY));
    expect(carListKey, findsOneWidget);

    // TODO 23: Call Verify Car Details function
    _verifyAllCarDetails(cars.items, tester);

    // TODO 24: Select a Car
    carsListBloc.selectItem(1);

    // TODO 25: Verify that Car is highlighted in green
    WidgetPredicate widgetSelectedPredicate = (Widget widget) =>
        widget is Card && widget.color == Colors.blue.shade200;
    WidgetPredicate widgetUnselectedPredicate =
        (Widget widget) => widget is Card && widget.color == Colors.white;

    expect(find.byWidgetPredicate(widgetSelectedPredicate), findsOneWidget);
    expect(find.byWidgetPredicate(widgetUnselectedPredicate), findsNWidgets(5));
  });

  testWidgets('Proper error message is shown when an error occured',
      (WidgetTester tester) async {
    // TODO 26: Inject and Load Error Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProviderError());

    // TODO 27: Load and render Widget
    await tester.pumpWidget(ListPageWrapper());
    await tester.pump(Duration.zero);

    // TODO 28: Verify that Error Message is shown
    final errorFinder =
        find.text(ERROR_MESSAGE.replaceFirst(WILD_STRING, MOCK_ERROR_MESSAGE));
    expect(errorFinder, findsOneWidget);
  });

  testWidgets(
      'After encountering an error, and stream is updated, Widget is also updated.',
      (WidgetTester tester) async {
    // TODO 29: Inject and Load Error Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProviderError());

    // TODO 30: Load and render Widget
    await tester.pumpWidget(ListPageWrapper());
    await tester.pump(Duration.zero);

    // TODO 31: Verify that Error Message is shown
    final errorFinder =
        find.text(ERROR_MESSAGE.replaceFirst(WILD_STRING, MOCK_ERROR_MESSAGE));
    expect(errorFinder, findsOneWidget);

    // TODO 32: Inject and Load Mock Car Data
    carsListBloc.injectDataProviderForTest(MockCarDataProvider());
    await carsListBloc.loadItems();

    // TODO 33: Reload Widget
    await tester.pump(Duration.zero);

    // TODO 34: Load and Verify Car Data
    CarsList cars = await MockCarDataProvider().loadCars();
    _verifyAllCarDetails(cars.items, tester);
  });
}

// TODO 22: Create a function to verify list's existence
void _verifyAllCarDetails(List<Car> carsList, WidgetTester tester) async {
  for (var car in carsList) {
    final carTitleFinder = find.text(car.title);
    final carPricePerDayFinder = find.text(PRICE_PER_DAY_TEXT.replaceFirst(
        WILD_STRING, car.pricePerDay.toStringAsFixed(2)));
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
      home: ListPage(),
    );
  }
}
