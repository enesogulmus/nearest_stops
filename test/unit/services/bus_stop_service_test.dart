import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearest_stops/services/bus_stop_service.dart';

void main() {
  group('BusStopService Tests', () {
    test('getNearbyBusStops durak sayısı testi', () {
      final userLocation = LatLng(41.0082, 28.9784);
      final stops = BusStopService.getNearbyBusStops(userLocation);
      
      expect(stops.length, BusStopService.numberOfStops);
    });

    test('getNearbyBusStops mesafe sıralaması testi', () {
      final userLocation = LatLng(41.0082, 28.9784);
      final stops = BusStopService.getNearbyBusStops(userLocation);
      
      // Durakların mesafeye göre sıralı olduğunu kontrol et
      for (int i = 0; i < stops.length - 1; i++) {
        expect(stops[i].distance, lessThanOrEqualTo(stops[i + 1].distance));
      }
    });

    test('getNearbyBusStops maksimum mesafe testi', () {
      final userLocation = LatLng(41.0082, 28.9784);
      final stops = BusStopService.getNearbyBusStops(userLocation);
      
      // Tüm durakların maksimum mesafe içinde olduğunu kontrol et
      for (final stop in stops) {
        expect(stop.distance, lessThanOrEqualTo(BusStopService.maxDistance));
      }
    });

    test('getNearbyBusStops benzersiz ID testi', () {
      final userLocation = LatLng(41.0082, 28.9784);
      final stops = BusStopService.getNearbyBusStops(userLocation);
      
      // Tüm durakların benzersiz ID'ye sahip olduğunu kontrol et
      final ids = stops.map((stop) => stop.id).toSet();
      expect(ids.length, stops.length);
    });
  });
} 