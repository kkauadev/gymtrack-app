import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/routes.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key, required this.index});

  final int index;

  @override
  State<StatefulWidget> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  final List<String> _routes = [
    Routes.build(path: "/home"),
    Routes.build(path: "/training-plan", param: "/1")
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, size: 28),
          activeIcon: Icon(Icons.home_rounded, size: 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_outlined, size: 28),
          activeIcon: Icon(Icons.list, size: 30),
          label: 'Treinos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, size: 28),
          activeIcon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.index,
      selectedItemColor: Theme.of(context).colorScheme.onPrimary,
      unselectedItemColor: Colors.grey,
      backgroundColor: Theme.of(context).colorScheme.primary,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      iconSize: 24,
      selectedFontSize: 14,
      unselectedFontSize: 12,
      onTap: (idx) => context.go(_routes[idx]),
    );
  }
}
