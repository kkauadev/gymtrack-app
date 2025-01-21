import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/training/training_repository_remote.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/training/list/view_models/training_list_view_model.dart';
import 'package:gymtrack/ui/pages/training/list/widgets/training_list_screen.dart';
import 'package:provider/provider.dart';

GoRoute trainingRoute = GoRoute(
  path: Routes.build(
    path: "/training",
    method: "/list",
    param: "/:dayId",
  ),
  pageBuilder: (ctx, state) => NoTransitionPage(
    child: TrainingListScreen(
      viewModel: TrainingListViewModel(
        trainingRepository: Provider.of<TrainingRepositoryRemote>(ctx),
        dayId: state.pathParameters['dayId']!,
      ),
    ),
  ),
);
