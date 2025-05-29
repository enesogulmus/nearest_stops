import 'package:latlong2/latlong.dart';
import 'dart:math';

import 'package:nearest_stops/models/bus_stop.dart';

class BusStopService {
  static final Random _random = Random();
  static const double maxDistance = 500; // metre cinsinden maksimum mesafe
  static const int numberOfStops = 5; // oluşturulacak durak sayısı

  // Rastgele durak isimleri
  static final List<String> _stopNames = [
    'Merkez Durak',
    'Şehir Meydanı',
    'Belediye',
    'Hastane',
    'Okul',
    'Park',
    'İstasyon',
    'Çarşı',
    'Spor Salonu',
    'Kütüphane',
  ];

  // Verilen konum etrafında rastgele bir nokta oluştur
  static LatLng _generateRandomLocation(LatLng center, double maxDistance) {
    // Rastgele bir açı seç (0-360 derece)
    final angle = _random.nextDouble() * 2 * pi;

    // Rastgele bir mesafe seç (0-maxDistance metre)
    final distance = _random.nextDouble() * maxDistance;

    // Haversine formülü ile yeni koordinatları hesapla
    const Distance distanceCalculator = Distance();
    return distanceCalculator.offset(center, distance, angle);
  }

  // Kullanıcının konumuna göre yakındaki durakları oluştur
  static List<BusStop> getNearbyBusStops(LatLng userLocation) {
    final List<BusStop> nearbyStops = [];

    // Rastgele durak isimlerini karıştır
    final shuffledNames = List<String>.from(_stopNames)..shuffle(_random);

    // Belirtilen sayıda durak oluştur
    for (int i = 0; i < numberOfStops; i++) {
      final randomLocation = _generateRandomLocation(userLocation, maxDistance);
      final distance = _calculateDistance(userLocation, randomLocation);

      nearbyStops.add(
        BusStop(
          id: (i + 1).toString(),
          name: shuffledNames[i % shuffledNames.length],
          location: randomLocation,
          distance: distance,
        ),
      );
    }

    // Mesafeye göre sırala
    nearbyStops.sort((a, b) => a.distance.compareTo(b.distance));

    return nearbyStops;
  }

  // Mesafayi hesapla
  static double _calculateDistance(LatLng start, LatLng end) {
    const Distance distance = Distance();
    return distance.as(LengthUnit.Meter, start, end);
  }

}
