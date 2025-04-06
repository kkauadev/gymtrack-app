import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
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
  final items = [
    MenuItems(
      label: "Aparência",
      onClick: () => print("logout"),
      icon: Icons.contrast_rounded,
    ),
    MenuItems(
      label: "Notificações",
      onClick: () => print("logout"),
      icon: Icons.notifications_none_rounded,
    ),
    MenuItems(
      label: "Localização",
      onClick: () => print("logout"),
      icon: Icons.location_on_rounded,
    ),
    MenuItems(
      label: "Logout",
      onClick: () => print("logout"),
      icon: Icons.logout_rounded,
    ),
    MenuItems(
      label: "Excluir conta",
      onClick: () => print("logout"),
      icon: Icons.delete_forever_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            CommandBuilder(
              command: widget.viewModel.loadUser,
              onData: (context, data, param) => UserProfileCard(
                user: data!,
              ),
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
