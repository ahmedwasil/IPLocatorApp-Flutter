/// Model class for IP location data returned from the API.
class IPLocation {
  final String ip;
  final double? latitude;
  final double? longitude;

  IPLocation({
    required this.ip,
    required this.latitude,
    required this.longitude,
  });

  /// Factory constructor to create an instance from API JSON response
  factory IPLocation.fromJson(Map<String, dynamic> json) {
    return IPLocation(
      ip: json['ip'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }
}
