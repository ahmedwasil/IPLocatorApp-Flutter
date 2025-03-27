import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ip_locator_provider.dart';
import '../widgets/input_field.dart';
import '../widgets/action_buttons.dart';
import '../widgets/error_message.dart';
import '../widgets/location_result.dart';
import '../widgets/loading_indicator.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ipLocatorProvider);
    final notifier = ref.read(ipLocatorProvider.notifier);
    final ipController = TextEditingController();

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
            ),
            const SizedBox(height: 20),
            if (state.isLoading) const LoadingIndicator(),
            if (state.errorMessage != null) ErrorMessage(message: state.errorMessage!),
            if (state.location != null) LocationResult(location: state.location!),
          ],
        ),
      ),
    );
  }
}
