import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/auth/auth_repository_remote.dart';
import 'package:gymtrack/data/repositories/day/day_repository_remote.dart';
import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository_remote.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/data/repositories/user/user_repository_remote.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/routing/route/exercise_route.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/auth/login/login_viewmodel.dart';
import 'package:gymtrack/ui/pages/auth/login/login_screen.dart';
import 'package:gymtrack/ui/pages/auth/signup/signup_viewmodel.dart';
import 'package:gymtrack/ui/pages/auth/signup/signup_screen.dart';
import 'package:gymtrack/ui/pages/settings/profile/settings_profile_screen.dart';
import 'package:gymtrack/ui/pages/settings/settings_screen.dart';
import 'package:gymtrack/ui/pages/settings/settings_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/create/day/days_create_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/create/day/days_create_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/create/training_plan_create_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/create/training_plans_create_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/create_options/training_plans_create_options_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/list/training_plans_list_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/list/training_plans_list_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/more_info/training_plan_more_info_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/more_info/training_plan_more_info_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/my_subscriptions_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/my_subscriptions_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/my_training_plans/my_training_plans_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/my_training_plans/my_training_plans_view_model.dart';
import 'package:provider/provider.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: Routes.build(path: "/login"),
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final authNotifierService =
          Provider.of<AuthNotifierService>(context, listen: false);
      final isAuthenticated = await authNotifierService.isAuthenticated();
      if (isAuthenticated && state.uri.path == '/login') {
        final userId = await authNotifierService.getUserId();
        if (userId == null) return null;

        return MySubscriptionsScreen.getPath();
      }

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.build(path: "/login"),
        builder: (context, state) => LoginScreen(
          viewModel: LoginViewModel(
            Provider.of<AuthRepositoryRemote>(context),
            Provider.of<AuthNotifierService>(context),
          ),
        ),
      ),
      GoRoute(
        path: Routes.build(path: "/signup"),
        builder: (context, state) => SignupScreen(
          viewModel: SignupViewmodel(
            authRepository: Provider.of<AuthRepositoryRemote>(context),
          ),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          final currentPath = state.uri.path;

          final tabs = <String>[
            MySubscriptionsScreen.getPath(),
            SettingsScreen.getPath()
          ];

          var currentIndex = tabs.indexOf(currentPath);
          if (currentIndex < 0) currentIndex = 0;

          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (i) {
                switch (i) {
                  case 0:
                    context.go(MySubscriptionsScreen.getPath());
                    break;
                  case 1:
                    context.go(SettingsScreen.getPath());
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.fitness_center),
                  label: 'Planos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Ajustes',
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: MySubscriptionsScreen.name,
            builder: (context, state) {
              return MySubscriptionsScreen(
                viewModel: MySubscriptionsViewModel(
                  planSubscriptionRepository:
                      Provider.of<PlanSubscriptionRepositoryRemote>(
                    context,
                  ),
                  authNotifierService:
                      Provider.of<AuthNotifierService>(context),
                ),
              );
            },
          ),
          GoRoute(
              path: SettingsScreen.name,
              builder: (context, state) {
                return SettingsScreen(
                  viewModel: SettingsViewModel(
                    userRepository: Provider.of<UserRepositoryRemote>(context),
                    authNotifierService:
                        Provider.of<AuthNotifierService>(context),
                  ),
                );
              },
              routes: [
                GoRoute(
                  path: SettingsProfileScreen.name,
                  builder: (context, state) {
                    return SettingsProfileScreen(
                      viewModel: SettingsViewModel(
                        userRepository:
                            Provider.of<UserRepositoryRemote>(context),
                        authNotifierService:
                            Provider.of<AuthNotifierService>(context),
                      ),
                    );
                  },
                )
              ]),
        ],
      ),
      GoRoute(
        path: TrainingPlansCreateOptionsScreen.name,
        builder: (context, state) => TrainingPlansCreateOptionsScreen(),
        routes: [
          GoRoute(
            path: TrainingPlansCreateScreen.name,
            builder: (context, state) {
              return TrainingPlansCreateScreen(
                viewModel: TrainingPlanCreateViewModel(
                  authNotifierService:
                      Provider.of<AuthNotifierService>(context),
                  trainingPlanRepository:
                      Provider.of<TrainingPlanRepositoryRemote>(context),
                ),
              );
            },
          ),
          GoRoute(
            path: TrainingPlansListScreen.name,
            builder: (context, state) {
              return TrainingPlansListScreen(
                viewModel: TrainingPlansListViewModel(
                  trainingPlanRepository:
                      Provider.of<TrainingPlanRepositoryRemote>(context),
                ),
              );
            },
          ),
          GoRoute(
            path: MyTrainingPlansScreen.name,
            builder: (context, state) {
              return MyTrainingPlansScreen(
                viewModel: MyTrainingPlansViewModel(
                  trainingPlanRepository:
                      Provider.of<TrainingPlanRepositoryRemote>(context),
                  authNotifierService:
                      Provider.of<AuthNotifierService>(context),
                ),
              );
            },
          ),
          GoRoute(
            path: TrainingPlanMoreInfoScreen.name,
            builder: (context, state) {
              return TrainingPlanMoreInfoScreen(
                viewModel: TrainingPlanMoreInfoViewModel(
                  authNotifierService:
                      Provider.of<AuthNotifierService>(context),
                  trainingPlanRepository:
                      Provider.of<TrainingPlanRepositoryRemote>(context),
                  planSubscriptionRepository:
                      Provider.of<PlanSubscriptionRepositoryRemote>(context),
                  trainingPlanId: state.pathParameters['trainingPlanId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: DaysCreateScreen.name,
            builder: (context, state) {
              return DaysCreateScreen(
                viewModel: DaysCreateViewModel(
                  dayRepository: Provider.of<DayRepositoryRemote>(context),
                  trainingPlanId: state.pathParameters['trainingPlanId']!,
                ),
              );
            },
          )
        ],
      ),
      exerciseRoute,
    ],
  );
}
