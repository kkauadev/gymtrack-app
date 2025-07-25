import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                PhosphorIcons.fire(PhosphorIconsStyle.fill),
                size: 80,
                color: Color(0xffe60f0f),
              ),
              Expanded(
                child: Text(
                  "30",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 56,
                      ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "de sequencia",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        ],
      ),
    );
  }
}
