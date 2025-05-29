import 'package:latlong2/latlong.dart';

class BusStop {
  final String id;
  final String name;
  final LatLng location;
  final double distance;

  BusStop({
    required this.id,
    required this.name,
    required this.location,
    this.distance = 0.0,
  });
}