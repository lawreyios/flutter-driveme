import 'package:driveme/dependency_injector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:driveme/models/car.dart';
import 'package:driveme/list/cars_list_bloc.dart';
import '../database/mock_car_data_provider.dart';

void main() {
  setupLocator();
  var carsListBloc = locator<CarsListBloc>();

  // test('List of Cars is well sorted in alphabectical order', () async {
    // TODO 3: Inject and Load Mock Car Data

    // TODO 4: Load Data from Data Stream

    // TODO 5: Load & Sort Mock Data for Verification

    // TODO 6: Verify Car Data

  // });

  // test('Stream is updated when a Car is Selected', () async {
    // TODO 7: Inject and Load Mock Car Data

    // TODO 8: Select a Car

    // TODO 9: Load Data from Second Data Stream

    // TODO 10: Verify Car is now Selected

  // });

  // test('Stream is updated when a Car is Deselected', () async {
    // TODO 11: Inject and Load Mock Car Data

    // TODO 12: Select a Car

    // TODO 13: Load Data from Second Data Stream

    // TODO 14: Verify that Car is deselected

    // TODO 15: Deselect a Car

    // TODO 16: Load Data from Second Data Stream again

    // TODO 17: Verify that Car is now deselected

  // });
}
