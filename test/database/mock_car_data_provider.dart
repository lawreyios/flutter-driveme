import 'dart:async';

import 'package:driveme/models/car.dart';
import 'package:driveme/list/list_bloc.dart';

// TODO 1: Read the Mock Test Data
class MockCarDataProvider implements CarsDataProvider {
  @override
  Future<CarsList> loadCars() async {
    List<Car> list = List<Car>();
    list.add(Car(
        1,
        "Toyota Yaris 2013",
        "This little 4 doors Toyota provide spacious that fit 5 people with decent trunk space. It is very eco-friendly with great gas mileage. It can easily park in the busy street in Los Angeles.",
        "",
        75.00,
        true, [
      "Remote Keyless Entry",
      "Anti-Lock Brakes (ABS)",
      "Electronic Stability/Skid-Control System",
      "Telescoping Steering Wheel"
    ]));
    list.add(Car(
        2,
        "Mercedes-Benz 2017",
        "Fully loaded black on black.  On top of the standard options includes: Nappa Leather Interior, Heads Up Display, 20\" AMG Multispoke wheels, Premium 1 Package (Ventilated seats, keyless go, parktronic, active multicontour seats with massage, rapid heating seats), Sport Package: (AMG Wheels and body, stainless steel sport pedals), Warmth and Comfort Package: (Heated steering wheel, power adjustable rear seats, heated front and rear armrests), Surround View system, Driver Assistance Package: (Distronic Plus with steering assist, active blind sport assist, active lane keeping assist, pre-safe brake, BAS Plus).",
        "",
        175.00,
        false, [
      "Remote Keyless Entry",
      "Anti-Lock Brakes (ABS)",
      "Electronic Stability/Skid-Control System",
      "Telescoping Steering Wheel"
    ]));
    list.add(Car(
        3,
        "Hyundai Sonata 2017",
        "Great on ⛽️, Roomy and comfortable for long distance trips , AUX and USB input.",
        "",
        275.00,
        false, [
      "Remote Keyless Entry",
      "Anti-Lock Brakes (ABS)",
      "Electronic Stability/Skid-Control System",
      "Telescoping Steering Wheel"
    ]));
    list.add(Car(
        4,
        "Tesla Model X 2018",
        "Meticulously maintained, but unfortunately the vehicle had a recent minor accident that damaged the rear right wheel's trim piece, but otherwise doesn't affect any of the sensors, waiting on tesla parts for a replacement. You will otherwise be renting a vehicle in impeccable shape with the deepest blacks with no tears, stains, food particles in crevices and interior is detailed after every rental. I have multiple Teslas  with renters experience in mind first and foremost. Will happily help above and beyond reasonable expectations. Equally good service as well as rates.",
        "",
        375.00,
        false, [
      "Remote Keyless Entry",
      "Anti-Lock Brakes (ABS)",
      "Electronic Stability/Skid-Control System",
      "Telescoping Steering Wheel"
    ]));
    list.add(Car(
        5,
        "Tesla Model S 2018",
        "Fully loaded and equipped with autopilot, Ludicrous and Ludicrous+ mode, free LTE internet, Google navigation system, full glass panoramic sunroof, carbon fiber interior, upgraded sound system, upgraded climate control system with all heated or cooling white leather seats and many more upgraded premium options.",
        "",
        475.00,
        false, [
      "Remote Keyless Entry",
      "Anti-Lock Brakes (ABS)",
      "Electronic Stability/Skid-Control System",
      "Telescoping Steering Wheel"
    ]));
    list.add(Car(
        6, "Scion xD 2014", "Great gas saver , AUX input.", "", 575.00, false, [
      "Remote Keyless Entry",
      "Anti-Lock Brakes (ABS)",
      "Electronic Stability/Skid-Control System",
      "Telescoping Steering Wheel"
    ]));
    return Future.value(CarsList(list, null));
  }
}
