import 'package:flutter/material.dart';

/// A text field for entering an IP address
class InputField extends StatelessWidget {
  final TextEditingController controller;

  const InputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Enter IP Address',
        border: OutlineInputBorder(),
      ),
    );
  }
}
