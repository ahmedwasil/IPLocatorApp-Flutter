import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ip_service.dart';
import '../viewmodels/ip_locator_view_model.dart';

/// Provides a singleton instance of the IPService
final ipServiceProvider = Provider<IPService>((ref) => IPService());

/// Provides the ViewModel (StateNotifier) for the IP locator
final ipLocatorProvider = StateNotifierProvider<IPLocatorNotifier, IPLocatorState>(
  (ref) => IPLocatorNotifier(ref.read(ipServiceProvider)),
);
