import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ip_locator_provider.dart';
import '../widgets/input_field.dart';
import '../widgets/action_buttons.dart';
import '../widgets/error_message.dart';
import '../widgets/location_result.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/map_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController ipController = TextEditingController();
  final GlobalKey<MapViewState> _mapKey = GlobalKey<MapViewState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ipLocatorProvider);
    final notifier = ref.read(ipLocatorProvider.notifier);

    // Move the map when location changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final location = state.location;
      if (location != null && location.latitude != null && location.longitude != null) {
        _mapKey.currentState?.updateLocation(location.latitude!, location.longitude!);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('IP Locator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(controller: ipController),
            const SizedBox(height: 12),
            ActionButtons(
              onGetMyIP: notifier.fetchMyIP,
              onLocateIP: () => notifier.fetchByIP(ipController.text),
              isLoading: state.isLoading,
            ),
            const SizedBox(height: 20),
            if (state.isLoading) const LoadingIndicator(),
            if (state.errorMessage != null) ErrorMessage(message: state.errorMessage!),
            if (state.location != null && state.errorMessage == null) ...[
              LocationResult(location: state.location!),
              const SizedBox(height: 16),
              MapView(key: _mapKey),
            ],
          ],
        ),
      ),
    );
  }
}
