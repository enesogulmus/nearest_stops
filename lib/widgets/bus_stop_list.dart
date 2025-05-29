import 'package:flutter/material.dart';
import '../models/bus_stop.dart';

class BusStopList extends StatelessWidget {
  final List<BusStop> busStops;

  const BusStopList({
    super.key,
    required this.busStops,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: busStops.length,
        itemBuilder: (context, index) {
          final stop = busStops[index];

          return ListTile(
            leading: const Icon(Icons.directions_bus),
            title: Text(stop.name),
            subtitle: Text('Mesafe: ${stop.distance.toStringAsFixed(0)} m'),
          );
        },
      ),
    );
  }
} 