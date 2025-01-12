import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).primaryTextTheme;

    return Column(
      children: [
        Text(label, style: textTheme.bodyMedium),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
