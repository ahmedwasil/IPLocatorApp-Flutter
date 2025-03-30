import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

/// A widget to show an OpenStreetMap with pin
/// Exposes an [updateLocation] method to allow external control
class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<StatefulWidget> createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  final MapController _mapController = MapController();
  LatLng? _location;

  // Call this from outside to update the map center
  void updateLocation(double latitude, double longitude) {
    final newLoc = LatLng(latitude, longitude);
    debugPrint('📍 New location: $newLoc');

    setState(() {
      _location = newLoc;
    });

    // Move the map only if it's attached
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        _mapController.move(newLoc, _mapController.camera.zoom);
      } catch (e) {
        debugPrint('❌ Failed to move map: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_location == null) {
      return const SizedBox(height: 300); //Empty Placeholder
    }

    return SizedBox(
        height: 300,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: _location!,
                    initialZoom: 15.5,
                    keepAlive: false,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.yourcompany.iplocator',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 40,
                          height: 40,
                          point: _location!,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ],
                ))));
  }
}
