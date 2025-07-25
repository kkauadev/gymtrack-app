import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/auth/auth_repository_remote.dart';
import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository_remote.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/data/repositories/user/user_repository_remote.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/routing/route/day_route.dart';
import 'package:gymtrack/routing/route/exercise_route.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/core/widgets/scaffold_with_navbar.dart';
import 'package:gymtrack/ui/pages/auth/login/login_viewmodel.dart';
import 'package:gymtrack/ui/pages/auth/login/login_screen.dart';
import 'package:gymtrack/ui/pages/auth/signup/signup_viewmodel.dart';
import 'package:gymtrack/ui/pages/auth/signup/signup_screen.dart';
import 'package:gymtrack/ui/pages/home/home_viewmodel.dart';
import 'package:gymtrack/ui/pages/home/home_screen.dart';
import 'package:gymtrack/ui/pages/settings/settings_screen.dart';
import 'package:gymtrack/ui/pages/settings/settings_view_model.dart';
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
      if (isAuthenticated && state.uri.path == '/login') return '/home';

      return null;
    },
    routes: [
      GoRoute(
        path: Routes.build(path: "/login"),
        builder: (context, state) => LoginScreen(
            viewModel:
                LoginViewModel(Provider.of<AuthRepositoryRemote>(context))),
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
        pageBuilder: (context, state, child) => NoTransitionPage(
          child: ScaffoldWithNavbar(
            location: Routes.build(path: "/home"),
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            path: Routes.build(path: "/home"),
            builder: (context, state) {
              return HomeScreen(viewModel: HomeViewModel());
            },
          ),
          GoRoute(
            path: "/settings",
            builder: (context, state) {
              return SettingsScreen(
                viewModel: SettingsViewModel(
                  userRepository: Provider.of<UserRepositoryRemote>(context),
                ),
              );
            },
          ),
          GoRoute(
            path: MySubscriptionsScreen.name,
            builder: (context, state) {
              return MySubscriptionsScreen(
                viewModel: MySubscriptionsViewModel(
                  userId: state.pathParameters['userId']!,
                  planSubscriptionRepository:
                      Provider.of<PlanSubscriptionRepositoryRemote>(
                    context,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: TrainingPlansCreateOptionsScreen.name,
        builder: (context, state) => TrainingPlansCreateOptionsScreen(
            userId: state.pathParameters['userId']!),
        routes: [
          GoRoute(
            path: TrainingPlansCreateScreen.name,
            builder: (context, state) {
              return TrainingPlansCreateScreen(
                viewModel: TrainingPlanCreateViewModel(
                  trainingPlanRepository:
                      Provider.of<TrainingPlanRepositoryRemote>(context),
                  userId: state.pathParameters['userId']!,
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
                  userId: state.pathParameters['userId']!,
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
                  userId: state.pathParameters['userId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: TrainingPlanMoreInfoScreen.name,
            builder: (context, state) {
              return TrainingPlanMoreInfoScreen(
                viewModel: TrainingPlanMoreInfoViewModel(
                  trainingPlanRepository:
                      Provider.of<TrainingPlanRepositoryRemote>(context),
                  planSubscriptionRepository:
                      Provider.of<PlanSubscriptionRepositoryRemote>(context),
                  userId: state.pathParameters['userId']!,
                  trainingPlanId: state.pathParameters['trainingPlanId']!,
                ),
              );
            },
          )
        ],
      ),
      dayRoute,
      exerciseRoute,
    ],
  );
}

//Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, they need to login
  //const bool loggedIn = true;
  //final bool loggingIn = state.matchedLocation == Routes.login;
  //if (!loggedIn) {
  //return Routes.login;
  //}

  // if the user is logged in but still on the login page, send them to
  // the home page
  //if (loggingIn) return Routes.login;

  // no need to redirect at all
  //return null;
//}
