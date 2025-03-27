import 'package:flutter/material.dart';

/// Two buttons: one to fetch own IP, one to look up a given IP
class ActionButtons extends StatelessWidget {
  final VoidCallback onGetMyIP;
  final VoidCallback onLocateIP;

  const ActionButtons({
    super.key,
    required this.onGetMyIP,
    required this.onLocateIP,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onGetMyIP,
            child: const Text('Get My IP'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: onLocateIP,
            child: const Text('Locate IP'),
          ),
        ),
      ],
    );
  }
}
