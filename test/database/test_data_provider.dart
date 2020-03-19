import 'dart:async';
import 'dart:convert';

import 'package:driveme/models/car.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;

class TestDataProvider implements CarsDataProvider {
  @override
  Future<CarsList> loadCars() async {
    try {
      final parsed = List<dynamic>.from(json.decode(
          await rootBundle.loadString('assets/test_data.json'))['cars']);
      final list = parsed.map((json) => Car.fromJson(json)).toList();
      list[0].selected = true;
      return CarsList(list, null);
    } catch (exception) {
      print(exception.toString());
      return CarsList(null, exception.toString());
    }
  }
}

class TestNewDataProvider implements CarsDataProvider {
  @override
  Future<CarsList> loadCars() async {
    List<Car> list = List<Car>();
    list.add(Car(1, "Car 1", "description", "", 75.00, false, []));
    list.add(Car(2, "Car 2", "description", "", 175.00, false, []));
    list.add(Car(3, "Car 3", "description", "", 275.00, true, []));
    list.add(Car(4, "Car 4", "description", "", 375.00, false, []));
    list.add(Car(5, "Car 5", "description", "", 475.00, false, []));
    list.add(Car(6, "Car 6", "description", "", 575.00, false, []));
    return Future.value(CarsList(list, null));
  }
}
