import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearest_stops/models/bus_stop.dart';

class MapWidget extends StatefulWidget {
  final LatLng userLocation;
  final List<BusStop> busStops;

  const MapWidget({super.key, required this.userLocation, required this.busStops});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(initialCenter: widget.userLocation, initialZoom: 16.0),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.altur_study_case',
            ),
            // Kullanıcı konumu marker'ı
            MarkerLayer(
              markers: [
                Marker(
                  point: widget.userLocation,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
                ),
              ],
            ),
            // Durak marker'ları
            MarkerLayer(
              markers:
                  widget.busStops.map((stop) {
                    return Marker(
                      point: stop.location,
                      width: 40,
                      height: 40,
                      child: Icon(Icons.directions_bus, color: Colors.green, size: 40),
                    );
                  }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}
