import 'package:flutter/material.dart';
import 'package:gymtrack/ui/core/widgets/input.dart';

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({super.key, required this.controller, required this.onTap});

  final TextEditingController controller;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          padding: EdgeInsets.symmetric(),
          child: Input(controller: controller),
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onTap,
            label: Text("Adicionar dia"),
            icon: Icon(Icons.add_outlined),
          ),
        ),
      ],
    );
  }
}
