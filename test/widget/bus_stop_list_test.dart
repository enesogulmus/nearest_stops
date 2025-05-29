import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearest_stops/models/bus_stop.dart';
import 'package:nearest_stops/widgets/bus_stop_list.dart';

void main() {
  group('BusStopList Widget Tests', () {
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

    testWidgets('BusStopList widget render testi', (WidgetTester tester) async {
      bool onBusStopSelectedCalled = false;
      BusStop? selectedStop;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BusStopList(
              busStops: testBusStops,
              onBusStopSelected: (stop) {
                onBusStopSelectedCalled = true;
                selectedStop = stop;
              },
            ),
          ),
        ),
      );

      // Widget'ın doğru şekilde render edildiğini kontrol et
      expect(find.byType(BusStopList), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(testBusStops.length));

      // Durak isimlerinin görüntülendiğini kontrol et
      expect(find.text('Test Durak 1'), findsOneWidget);
      expect(find.text('Test Durak 2'), findsOneWidget);

      // Mesafe bilgilerinin görüntülendiğini kontrol et
      expect(find.text('Mesafe: 100 m'), findsOneWidget);
      expect(find.text('Mesafe: 200 m'), findsOneWidget);
    });

    testWidgets('BusStopList seçim işlevi testi', (WidgetTester tester) async {
      bool onBusStopSelectedCalled = false;
      BusStop? selectedStop;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BusStopList(
              busStops: testBusStops,
              onBusStopSelected: (stop) {
                onBusStopSelectedCalled = true;
                selectedStop = stop;
              },
            ),
          ),
        ),
      );

      // İlk durağa tıkla
      await tester.tap(find.text('Test Durak 1'));
      await tester.pump();

      // Callback'in çağrıldığını ve doğru durağın seçildiğini kontrol et
      expect(onBusStopSelectedCalled, true);
      expect(selectedStop?.id, '1');
    });

    testWidgets('BusStopList seçili durak görünümü testi', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BusStopList(
              busStops: testBusStops,
              selectedBusStop: testBusStops[0],
              onBusStopSelected: (_) {},
            ),
          ),
        ),
      );

      // Seçili durağın görsel olarak vurgulandığını kontrol et
      final selectedTile = tester.widget<ListTile>(find.byType(ListTile).first);
      expect(selectedTile.selected, true);
    });
  });
} 