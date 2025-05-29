import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearest_stops/models/bus_stop.dart';

void main() {
  group('BusStop Model Tests', () {
    test('BusStop oluşturma testi', () {
      final location = LatLng(41.0082, 28.9784);
      final busStop = BusStop(
        id: '1',
        name: 'Test Durak',
        location: location,
        distance: 100.0,
      );

      expect(busStop.id, '1');
      expect(busStop.name, 'Test Durak');
      expect(busStop.location, location);
      expect(busStop.distance, 100.0);
    });

    test('BusStop varsayılan mesafe değeri testi', () {
      final location = LatLng(41.0082, 28.9784);
      final busStop = BusStop(
        id: '1',
        name: 'Test Durak',
        location: location,
      );

      expect(busStop.distance, 0.0);
    });
  });
} 