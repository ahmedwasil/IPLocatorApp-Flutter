import 'package:dio/dio.dart';
import "../models/ip_location.dart";

/// Service class responsible for fetching IP location data from ipapi.co
class IPService {
  final Dio _dio;

  /// Can inject a cusom Dio instance (e.g. for testing)
  IPService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetches location info the for given IP address.
  /// If no IP is passed, fetches the current public IP of the user.
  Future<IPLocation> fetchIPLocation([String? ip]) async {
    // final url = ip == null || ip.isEmpty ? 'https://ipapi.co/json/' : 'https://ipapi.co/$ip/json/';
    final url = ip == null || ip.isEmpty ? 'https://ipwho.is/' : 'https://ipwho.is/$ip';
    print('➡️ Fetching: $url');
    try {
      final response = await _dio.get(url);
      print('✅ Response: ${response.data}');
      return IPLocation.fromJson(response.data);
    } catch (e) {
      print('❌ Dio error: $e');
      throw Exception('Failed to fetch location');
    }
  }
}
