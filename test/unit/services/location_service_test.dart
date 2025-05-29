import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:nearest_stops/services/location_service.dart';

@GenerateMocks([Geolocator])
void main() {
  group('LocationService Tests', () {
    test('positionToLatLng dönüşüm testi', () {
      final position = Position(
        latitude: 41.0082,
        longitude: 28.9784,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );

      final latLng = LocationService.positionToLatLng(position);
      expect(latLng.latitude, 41.0082);
      expect(latLng.longitude, 28.9784);
    });
  });
} 