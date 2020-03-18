import 'dart:async';
import 'dart:convert';

import 'package:driveme/models/car.dart';
import 'package:driveme/list/list_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;

class TestDataProvider implements CarsDataProvider {
  @override
  Future<CarsList> loadCars() async {
    try {
      final parsed = List<dynamic>.from(
          json.decode(await rootBundle.loadString('assets/test_data.json'))['cars']);
      final list = parsed.map((json) => Car.fromJson(json)).toList();
      return CarsList(list, null);
    } catch (exception) {
      return CarsList(null, exception.toString());
    }
  }
}
