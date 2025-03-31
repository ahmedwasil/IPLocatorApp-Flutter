import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ip_locator_app/utils/utils.dart';
import '../models/ip_location.dart';
import '../services/ip_service.dart';

/// Represents the state of the IP Locator feature
class IPLocatorState {
  final bool isLoading;
  final IPLocation? location;
  final String? errorMessage;

  const IPLocatorState({
    this.isLoading = false,
    this.location,
    this.errorMessage,
  });

  /// Returns a copy of the current state with updated values
  IPLocatorState copyWith({
    bool? isLoading,
    IPLocation? location,
    String? errorMessage,
  }) {
    return IPLocatorState(
      isLoading: isLoading ?? this.isLoading,
      location: location ?? this.location,
      errorMessage: errorMessage,
    );
  }

  /// Helper for resetting state to defauls
  static IPLocatorState initial() => const IPLocatorState();
}

/// The ViewModel / StateNotifier that holds app logic and state
class IPLocatorNotifier extends StateNotifier<IPLocatorState> {
  final IPService ipService;

  IPLocatorNotifier(this.ipService) : super(IPLocatorState.initial());

  /// Fetches the location of the users current IP
  Future<void> fetchMyIP() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await ipService.fetchIPLocation();
      state = state.copyWith(location: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Fetches location for manually entered IP address
  Future<void> fetchByIP(String ip) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    if (!Utils.isValidIP(ip)) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '❌ Invalid IP address format.',
      );
      return;
    }

    try {
      final result = await ipService.fetchIPLocation(ip);
      state = state.copyWith(location: result, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  /// Resets all state — can be used for clearing the screen
  void clear() {
    state = IPLocatorState.initial();
  }
}
