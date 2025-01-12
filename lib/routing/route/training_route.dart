import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/training/training_repository_remote.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/training/list/view_models/training_list_view_model.dart';
import 'package:gymtrack/ui/pages/training/list/widgets/training_list_screen.dart';
import 'package:provider/provider.dart';

GoRoute trainingRoute = GoRoute(
  path: Routes.build(
    path: "/training",
    method: "/list",
    param: "/:trainingPlanId",
  ),
  pageBuilder: (ctx, state) => NoTransitionPage(
    child: TrainingListScreen(
      viewModel: TrainingListViewModel(
        trainingPlanRepository: Provider.of<TrainingPlanRepositoryRemote>(
          ctx,
        ),
        trainingRepository: Provider.of<TrainingRepositoryRemote>(ctx),
        trainingPlanId: state.pathParameters['trainingPlanId']!,
      ),
    ),
  ),
);
