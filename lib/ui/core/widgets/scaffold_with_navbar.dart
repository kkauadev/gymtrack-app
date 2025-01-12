import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/routes.dart';

class ScaffoldWithNavbar extends StatefulWidget {
  final String location;
  const ScaffoldWithNavbar({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;

  @override
  State<StatefulWidget> createState() => _ScaffoldWithNavbarState();
}

class _ScaffoldWithNavbarState extends State<ScaffoldWithNavbar> {
  int _currentIndex = 0;

  static List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.home_outlined, size: 28),
      activeIcon: Icon(Icons.home_rounded, size: 30),
      label: 'Home',
      initialLocation: Routes.build(path: "/home"),
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.list_outlined, size: 28),
      activeIcon: Icon(Icons.list, size: 30),
      label: 'Treinos',
      initialLocation: Routes.build(
        path: "/training-plan",
        param: "/1",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        unselectedItemColor: Colors.grey,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        iconSize: 24,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: _currentIndex,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });
    if (index == 3) {
      context.push('/login');
    } else {
      router.go(location);
    }
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem({
    required this.initialLocation,
    required super.icon,
    super.label,
    Widget? activeIcon,
  }) : super(activeIcon: activeIcon ?? icon);
}
