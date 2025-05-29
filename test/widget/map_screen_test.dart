import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nearest_stops/screens/map_screen.dart';

void main() {
  group('MapScreen Widget Tests', () {
    testWidgets('MapScreen render testi', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MapScreen(),
        ),
      );

      // MapScreen'in render edildiğini kontrol et
      expect(find.byType(MapScreen), findsOneWidget);
    });
  });
} 