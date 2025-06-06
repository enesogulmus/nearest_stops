import 'package:flutter/material.dart';
import '../models/bus_stop.dart';

class BusStopList extends StatelessWidget {
  final List<BusStop> busStops;
  final BusStop? selectedBusStop;
  final Function(BusStop) onBusStopSelected;

  const BusStopList({super.key, required this.busStops, this.selectedBusStop, required this.onBusStopSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: busStops.length,
        itemBuilder: (context, index) {
          final stop = busStops[index];
          final isSelected = selectedBusStop?.id == stop.id;

          return ListTile(
            leading: const Icon(Icons.directions_bus),
            title: Text(stop.name),
            subtitle: Text('Mesafe: ${stop.distance.toStringAsFixed(0)} m'),
            selected: isSelected,
            selectedTileColor: Colors.blue.withValues(alpha: 0.1),
            onTap: () => onBusStopSelected(stop),
          );
        },
      ),
    );
  }
} 