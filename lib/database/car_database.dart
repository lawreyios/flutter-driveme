import 'dart:async';
import 'dart:convert';
import 'package:driveme/models/car.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:driveme/list/list_bloc.dart';

class CarDatabase implements CarsDataProvider {

  static final CarDatabase _singleton = new CarDatabase._internal();

  factory CarDatabase() {
    return _singleton;
  }

  CarDatabase._internal();

  @override
  Future<CarsList> loadCars() async {
    try {
      final parsed = List<dynamic>.from(json.decode(await rootBundle.loadString('assets/data.json'))['cars']);
      final list = parsed.map((json) => Car.fromJson(json)).toList();
      return CarsList(list, null);
    } catch (exception) {
      return CarsList(null, exception.toString());
    }
  }

}