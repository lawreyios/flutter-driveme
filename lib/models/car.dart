class Car {
  final int id;
  final String title;
  final String description;
  final String url;
  final double pricePerDay;
  final bool selected;
  final List<dynamic> features;

  Car(this.id, this.title, this.description, this.url, this.pricePerDay,
      this.selected, this.features);

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
        json['id'] as int,
        json['title'] as String,
        json['description'] as String,
        json['url'] as String,
        json['pricePerDay'] as double,
        false,
        json['features']);
  }
}

class CarsList {
  final List<Car> items;

  final String errorMessage;

  CarsList(this.items, this.errorMessage);
}
