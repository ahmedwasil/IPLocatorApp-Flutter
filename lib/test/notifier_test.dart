import 'package:flutter_test/flutter_test.dart';
import 'package:ip_locator_app/viewmodels/ip_locator_view_model.dart';
import 'package:riverpod/riverpod.dart';
import 'package:ip_locator_app/providers/ip_locator_provider.dart';
import 'package:ip_locator_app/models/ip_location.dart';
import 'package:ip_locator_app/services/ip_service.dart';

class MockIPService implements IPService {
  IPLocation? mockLocation;
  bool shouldThrow = false;

  @override
  Future<IPLocation> fetchIPLocation([String? ip]) async {
    if (shouldThrow) throw Exception('Mocked failure');
    return mockLocation!;
  }
}

void main() {
  test('fetchByIP with invalid IP sets errorMessage', () async {
    final container = ProviderContainer(overrides: [ipServiceProvider.overrideWith((ref) => MockIPService())]);

    final notifier = container.read(ipLocatorProvider.notifier);

    await notifier.fetchByIP('not.an.ip');

    final state = container.read(ipLocatorProvider);
    expect(state.isLoading, isFalse);
    expect(state.location, isNull);
    expect(state.errorMessage, '❌ Invalid IP address format.');
  });

  test('fetchByIP with valid IP sets location', () async {
    final mockService = MockIPService()..mockLocation = IPLocation(ip: '1.2.3.4', latitude: 1.0, longitude: 2.0);

    final container = ProviderContainer(
      overrides: [
        ipServiceProvider.overrideWith((ref) => mockService),
      ],
    );

    final notifier = container.read(ipLocatorProvider.notifier);

    await notifier.fetchByIP('1.2.3.4');

    final state = container.read(ipLocatorProvider);
    expect(state.isLoading, isFalse);
    expect(state.location, isNotNull);
    expect(state.location!.ip, '1.2.3.4');
  });

  test('fetchMyIP sets location correctly', () async {
    final mockService = MockIPService()..mockLocation = IPLocation(ip: '9.9.9.9', latitude: 5.5, longitude: 6.6);

    final container = ProviderContainer(
      overrides: [
        ipServiceProvider.overrideWith((ref) => mockService),
      ],
    );

    final notifier = container.read(ipLocatorProvider.notifier);

    await notifier.fetchMyIP();

    final state = container.read(ipLocatorProvider);
    expect(state.location, isNotNull);
    expect(state.location!.ip, '9.9.9.9');
  });

  test('fetchMyIP handles service failure gracefully', () async {
    final mockService = MockIPService()..shouldThrow = true;

    final container = ProviderContainer(
      overrides: [
        ipServiceProvider.overrideWith((ref) => mockService),
      ],
    );

    final notifier = container.read(ipLocatorProvider.notifier);

    await notifier.fetchMyIP();

    final state = container.read(ipLocatorProvider);
    expect(state.location, isNull);
    expect(state.errorMessage, contains('Mocked failure'));
  });

  test('clear() resets to initial state', () async {
    final mockService = MockIPService()..mockLocation = IPLocation(ip: '7.7.7.7', latitude: 0, longitude: 0);

    final container = ProviderContainer(
      overrides: [
        ipServiceProvider.overrideWith((ref) => mockService),
      ],
    );

    final notifier = container.read(ipLocatorProvider.notifier);
    notifier.clear();

    final state = container.read(ipLocatorProvider);
    expect(state.isLoading, isFalse);
    expect(state.location, isNull);
    expect(state.errorMessage, isNull);
  });
}
