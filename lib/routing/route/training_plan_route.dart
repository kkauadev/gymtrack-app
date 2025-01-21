import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/training_plan/create/view_models/training_plan_create_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/create/widgets/training_plans_create_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/create_options/widgets/training_plans_create_options_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/list/view_models/training_plans_list_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/list/widgets/training_plans_list_screen.dart';
import 'package:provider/provider.dart';

GoRoute trainingPlanRoute = GoRoute(
  path: Routes.build(
    path: "/training-plan",
    param: "/:userId",
  ),
  pageBuilder: (context, state) => NoTransitionPage(
    child: TrainingPlansListScreen(
      viewModel: TrainingPlansListViewModel(
        trainingPlanRepository: Provider.of<TrainingPlanRepositoryRemote>(
          context,
        ),
        userId: state.pathParameters['userId']!,
      ),
    ),
  ),
  routes: [
    GoRoute(
      path: Routes.build(method: "/create-options"),
      pageBuilder: (context, state) => NoTransitionPage(
        child: TrainingPlansCreateOptionsScreen(
          userId: state.pathParameters['userId']!,
        ),
      ),
    ),
    GoRoute(
      path: Routes.build(method: "/create"),
      pageBuilder: (context, state) => NoTransitionPage(
        child: TrainingPlansCreateScreen(
          viewModel: TrainingPlanCreateViewModel(
            trainingPlanRepository:
                Provider.of<TrainingPlanRepositoryRemote>(context),
            userId: state.pathParameters['userId']!,
          ),
        ),
      ),
    ),
  ],
);
