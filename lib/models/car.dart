import 'package:driveme/constants.dart';

class Car {
  final int id;
  final String title;
  final String description;
  final String url;
  final double pricePerDay;
  bool selected;
  final List<dynamic> features;

  Car(this.id, this.title, this.description, this.url, this.pricePerDay,
      this.selected, this.features);

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        json[CARS_ID_KEY] as int,
        json[CARS_TITLE_KEY] as String,
        json[CARS_DESCRIPTION_KEY] as String,
        json[CARS_URL_KEY] as String,
        json[CARS_PRICEPERDAY_KEY] as double,
        false,
        json[CARS_FEATURES_KEY]);
  }
}

class CarsList {
  final List<Car> items;

  final String errorMessage;

  CarsList(this.items, this.errorMessage);
}
