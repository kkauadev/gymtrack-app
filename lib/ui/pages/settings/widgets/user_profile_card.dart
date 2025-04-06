import 'package:flutter/material.dart';
import 'package:gymtrack/domain/models/user.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFEAEAEA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              spacing: 12,
              children: [
                //Container(
                //  height: 80,
                //  width: 80,
                //  decoration: BoxDecoration(
                //    shape: BoxShape.circle,
                //    color: Color(0xFFAAAAAA),
                //  ),
                //),
                Expanded(
                  child: Text(
                    user.username,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_right_rounded, size: 36)
        ],
      ),
    );
  }
}
