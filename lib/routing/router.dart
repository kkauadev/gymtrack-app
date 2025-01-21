import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/route/day_route.dart';
import 'package:gymtrack/routing/route/exercise_route.dart';
import 'package:gymtrack/routing/route/training_plan_route.dart';
import 'package:gymtrack/routing/route/training_route.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/core/widgets/scaffold_with_navbar.dart';
import 'package:gymtrack/ui/pages/auth/login/view_models/login_viewmodel.dart';
import 'package:gymtrack/ui/pages/auth/login/widgets/login_screen.dart';
import 'package:gymtrack/ui/pages/auth/signup/view_models/signup_viewmodel.dart';
import 'package:gymtrack/ui/pages/auth/signup/widgets/signup_screen.dart';
import 'package:gymtrack/ui/pages/home/view_models/home_viewmodel.dart';
import 'package:gymtrack/ui/pages/home/widgets/home_screen.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: Routes.build(path: "/login"),
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.build(path: "/login"),
        builder: (context, state) => LoginScreen(viewModel: LoginViewModel()),
      ),
      GoRoute(
        path: Routes.build(path: "/signup"),
        pageBuilder: (context, state) => NoTransitionPage(
          child: SignupScreen(viewModel: SignupViewmodel()),
        ),
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => NoTransitionPage(
          child: ScaffoldWithNavbar(
              location: Routes.build(
                path: "/home",
              ),
              child: child),
        ),
        routes: [
          GoRoute(
            path: Routes.build(path: "/home"),
            pageBuilder: (context, state) => NoTransitionPage(
              child: HomeScreen(viewModel: HomeViewModel()),
            ),
          ),
          trainingPlanRoute
        ],
      ),
      dayRoute,
      trainingRoute,
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
