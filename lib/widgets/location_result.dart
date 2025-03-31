import 'package:flutter/material.dart';
import '../models/ip_location.dart';

/// Displays IP address and coordinates from the result
class LocationResult extends StatelessWidget {
  final IPLocation location;

  const LocationResult({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('IP: ${location.ip}'),
          Text('Latitude: ${location.latitude}'),
          Text('Longitude: ${location.longitude}'),
        ],
      ),
    );
  }
}
