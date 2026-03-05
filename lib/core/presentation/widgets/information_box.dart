import 'package:flutter/material.dart';
import '../../extensions/context_extensions.dart';

class InformationBox extends StatelessWidget {
  final String message;

  const InformationBox({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // bg-blue-50
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFBFDBFE), // border-blue-200
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ℹ️'),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: context.textTheme.labelSmall)),
        ],
      ),
    );
  }
}
