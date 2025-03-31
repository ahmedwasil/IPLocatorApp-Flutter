import 'package:flutter/material.dart';

/// Two buttons: one to fetch own IP, one to look up a given IP
class ActionButtons extends StatelessWidget {
  final VoidCallback onGetMyIP;
  final VoidCallback onLocateIP;
  final bool isLoading;

  const ActionButtons({
    super.key,
    required this.onGetMyIP,
    required this.onLocateIP,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onGetMyIP,
            child: const Text('Get My IP'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onLocateIP,
            child: const Text('Locate IP'),
          ),
        ),
      ],
    );
  }
}
