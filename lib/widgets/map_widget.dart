import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nearest_stops/models/bus_stop.dart';
import 'package:nearest_stops/services/api_key_service.dart';
import 'package:open_route_service/open_route_service.dart';

class MapWidget extends StatefulWidget {
  final LatLng userLocation;
  final List<BusStop> busStops;
  final BusStop? selectedBusStop;
  final Function(BusStop?) onBusStopSelected;

  const MapWidget({
    super.key,
    required this.userLocation,
    required this.busStops,
    this.selectedBusStop,
    required this.onBusStopSelected,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  List<LatLng>? _routePoints;
  late final OpenRouteService _openRouteService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeOpenRouteService();
  }

  void _initializeOpenRouteService() {
    final apiKey = ApiKeyService.getApiKey();

    if (apiKey != null) {
      _openRouteService = OpenRouteService(apiKey: apiKey);
    }
  }

  @override
  void didUpdateWidget(MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedBusStop != oldWidget.selectedBusStop) {
      _fetchRoute();
    }
  }

  Future<void> _fetchRoute() async {
    if (widget.selectedBusStop == null || !ApiKeyService.hasApiKey()) {
      setState(() => _routePoints = null);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final startCoord = [widget.userLocation.longitude, widget.userLocation.latitude]; // Mevcut konum
      final endCoord = [
        widget.selectedBusStop!.location.longitude,
        widget.selectedBusStop!.location.latitude,
      ]; // Hedef nokta

      // Rota koordinatlarını getir
      final response = await _openRouteService.directionsRouteGeoJsonGet(
        startCoordinate: ORSCoordinate.fromList(startCoord),
        endCoordinate: ORSCoordinate.fromList(endCoord),
        profileOverride: ORSProfile.footWalking,
      );

      if (response.features.isNotEmpty) {
        final coordinates = response.features.first.geometry.coordinates;

        setState(() {
          _routePoints =
              coordinates.first.map((coord) {
                return LatLng(coord.latitude, coord.longitude);
              }).toList();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rota çizimi sırasında bir hata oluştu: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      setState(() => _routePoints = null);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: widget.userLocation,
            initialZoom: 16.0,
            onTap: (_, __) {
              widget.onBusStopSelected(null);
            },
          ),
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
                      child: GestureDetector(
                        onTap: () {
                          widget.onBusStopSelected(stop);
                        },
                        child: Icon(
                          Icons.directions_bus,
                          color: widget.selectedBusStop?.id == stop.id ? Colors.red : Colors.green,
                          size: 40,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            if (_routePoints != null)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints!,
                    color: Colors.blue,
                    strokeWidth: 4,
                    borderColor: Colors.white,
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
          ],
        ),
        if (_isLoading) const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
