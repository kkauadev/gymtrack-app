import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/ui/pages/settings/settings_view_model.dart';
import 'package:gymtrack/ui/pages/settings/widgets/app_info.dart';
import 'package:gymtrack/ui/pages/settings/widgets/menu_item.dart';
import 'package:gymtrack/ui/pages/settings/widgets/user_profile_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.viewModel});

  final SettingsViewModel viewModel;

  @override
  State<StatefulWidget> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final items = [
      MenuItems(
        label: "Conta",
        onClick: () => context.push("/settings/profile"),
        icon: Icons.person,
      ),
      MenuItems(
        label: "Logout",
        onClick: () async {
          await widget.viewModel.logout.executeWithFuture();
          if (context.mounted) {
            context.push("/login");
          }
        },
        icon: Icons.logout_rounded,
      ),
    ];

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            CommandBuilder(
              command: widget.viewModel.loadUser,
              onData: (context, data, param) => UserProfileCard(),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => Container(
                height: 2,
                color: Color(0xFFEAEAEA),
              ),
              itemBuilder: (context, index) => MenuItem(item: items[index]),
            ),
            AppInfo()
          ],
        ),
      ),
    );
  }
}
