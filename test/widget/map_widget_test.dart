import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearest_stops/models/bus_stop.dart';
import 'package:nearest_stops/widgets/map_widget.dart';

void main() {
  group('MapWidget Widget Tests', () {
    final testBusStops = [
      BusStop(
        id: '1',
        name: 'Test Durak 1',
        location: LatLng(41.0082, 28.9784),
        distance: 100.0,
      ),
      BusStop(
        id: '2',
        name: 'Test Durak 2',
        location: LatLng(41.0083, 28.9785),
        distance: 200.0,
      ),
    ];

    testWidgets('MapWidget render testi', (WidgetTester tester) async {
      await dotenv.load(fileName: ".env");
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MapWidget(
              busStops: testBusStops,
              userLocation: LatLng(41.0082, 28.9784),
              selectedBusStop: testBusStops[0],
              onBusStopSelected: (_) {},
            ),
          ),
        ),
      );

      // MapWidget'ın render edildiğini kontrol et
      expect(find.byType(MapWidget), findsOneWidget);
    });
  });
} 