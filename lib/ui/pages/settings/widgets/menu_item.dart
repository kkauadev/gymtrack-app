import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenuItems {
  final String label;
  final void Function() onClick;
  final IconData? icon;

  MenuItems({required this.label, required this.onClick, this.icon});
}

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.item});

  final MenuItems item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onClick,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        height: 62,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (item.icon != null) ...[
              Icon(item.icon, color: Color(0xFF777777))
            ]
          ],
        ),
      ),
    );
  }
}
