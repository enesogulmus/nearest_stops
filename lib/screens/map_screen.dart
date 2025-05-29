import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearest_stops/models/bus_stop.dart';
import 'package:nearest_stops/services/bus_stop_service.dart';
import 'package:nearest_stops/widgets/map_widget.dart';

import '../services/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _userLocation;
  List<BusStop> _nearbyBusStops = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      final userLocation = LocationService.positionToLatLng(position);

      setState(() {
        _userLocation = userLocation;
        _nearbyBusStops = BusStopService.getNearbyBusStops(userLocation);
        _error = null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _initializeLocation, child: const Text('Tekrar Dene')),
            ],
          ),
        ),
      );
    }

    if (_userLocation == null) {
      return const Scaffold(body: Center(child: Text('Konum alınamadı')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Yakındaki Duraklar')),
      body: MapWidget(userLocation: _userLocation!, busStops: _nearbyBusStops),
    );
  }
}
