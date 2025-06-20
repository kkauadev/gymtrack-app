import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/user/user_repository_remote.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/ui/pages/settings/customize/settings_customize_screen.dart';
import 'package:gymtrack/ui/pages/settings/profile/settings_profile_screen.dart';
import 'package:gymtrack/ui/pages/settings/settings_screen.dart';
import 'package:gymtrack/ui/pages/settings/settings_view_model.dart';
import 'package:provider/provider.dart';

GoRoute settingsRoute = GoRoute(
  path: "/settings",
  pageBuilder: (context, state) => NoTransitionPage(
    child: SettingsScreen(
      viewModel: SettingsViewModel(
        userRepository: Provider.of<UserRepositoryRemote>(context),
        authNotifierService: Provider.of<AuthNotifierService>(context),
      ),
    ),
  ),
  routes: [
    GoRoute(
      path: "/profile",
      pageBuilder: (context, state) => NoTransitionPage(
        child: SettingsProfileScreen(
          viewModel: SettingsViewModel(
            userRepository: Provider.of<UserRepositoryRemote>(context),
            authNotifierService: Provider.of<AuthNotifierService>(context),
          ),
        ),
      ),
    ),
    GoRoute(
      path: "/customize",
      pageBuilder: (context, state) => NoTransitionPage(
        child: SettingsCustomizeScreen(),
      ),
    ),
    GoRoute(
      path: "/profile",
      pageBuilder: (context, state) => NoTransitionPage(
        child: SettingsCustomizeScreen(),
      ),
    ),
    GoRoute(
      path: "/profile",
      pageBuilder: (context, state) => NoTransitionPage(
        child: SettingsCustomizeScreen(),
      ),
    ),
    GoRoute(
      path: "/profile",
      pageBuilder: (context, state) => NoTransitionPage(
        child: SettingsCustomizeScreen(),
      ),
    )
  ],
);
