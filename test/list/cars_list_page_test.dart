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
      "Cars are displayed with summary details, and selected car is highlighted in blue.",
      (WidgetTester tester) async {
    // TODO 18: Inject and Load Mock Car Data

    // TODO 19: Load & Sort Mock Data for Verification

    // TODO 20: Load and render Widget

    // TODO 21: Check Cars List's component's existence via key

    // TODO 23: Call Verify Car Details function

    // TODO 24: Select a Car

    // TODO 25: Verify that Car is highlighted in blue

  });

  testWidgets('Proper error message is shown when an error occurred',
      (WidgetTester tester) async {
    // TODO 26: Inject and Load Error Mock Car Data

    // TODO 27: Load and render Widget

    // TODO 28: Verify that Error Message is shown

  });

  testWidgets(
      'After encountering an error, and stream is updated, Widget is also updated.',
      (WidgetTester tester) async {
    // TODO 29: Inject and Load Error Mock Car Data

    // TODO 30: Load and render Widget

    // TODO 31: Verify that Error Message and Retry Button is shown

    // TODO 32: Inject and Load Mock Car Data

    // TODO 33: Reload Widget

    // TODO 34: Load and Verify Car Data

  });
}

// TODO 22: Create a function to verify list's existence

class ListPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListPage(),
    );
  }
}
