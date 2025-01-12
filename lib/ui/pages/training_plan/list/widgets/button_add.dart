import 'package:flutter/material.dart';

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Icon(
        Icons.add_rounded,
        size: 40,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
