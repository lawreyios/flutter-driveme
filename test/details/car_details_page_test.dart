import 'package:driveme/constants.dart';
import 'package:driveme/dependency_injector.dart';
import 'package:driveme/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/details/car_details_page.dart';
import 'package:driveme/list/cars_list_bloc.dart';

import '../database/mock_car_data_provider.dart';

CarsList cars;

void main() {

  setupLocator();
  var carsListBloc = locator<CarsListBloc>();

  testWidgets('Unselected Car Details Page should be shown as Unselected', (WidgetTester tester) async {
    // TODO 21: Inject and Load Mock Car Data

    // TODO 22: Load & Sort Mock Data for Verification

    // TODO 23: Load and render Widget

    // TODO 24: Verify Car Details

  });

  testWidgets('Selected Car Details Page should be shown as Selected',
      (WidgetTester tester) async {
    // TODO 25: Inject and Load Mock Car Data

    // TODO 26: Load and render Widget

    // TODO 27: Load Mock Data for Verification

    // TODO 28: First Car is Selected, so Verify that

  });

  testWidgets('Selecting Car Updates the Widget', (WidgetTester tester) async {
    // TODO 29: Inject and Load Mock Car Data

    // TODO 30: Load & Sort Mock Data for Verification

    // TODO 31: Load and render Widget for the first car

    // TODO 32: Tap on Select and Deselect to ensure widget updates

  });
}

class DetailsPageSelectedWrapper extends StatelessWidget {
  final int id;

  DetailsPageSelectedWrapper(this.id);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CarDetailsPage(id: id),
    );
  }
}
