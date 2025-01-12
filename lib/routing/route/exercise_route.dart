import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/exercise/exercise_repository_remote.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/exercise/list/view_models/exercise_list_view_model.dart';
import 'package:gymtrack/ui/pages/exercise/list/widgets/exercice_list_screen.dart';
import 'package:provider/provider.dart';

GoRoute exerciseRoute = GoRoute(
  path: Routes.build(
    path: "/exercise",
    method: "/list",
    param: "/:trainingId",
  ),
  pageBuilder: (context, state) => NoTransitionPage(
    child: ExerciceListScreen(
      viewModel: ExerciseListViewModel(
        exerciseRepository: Provider.of<ExerciseRepositoryRemote>(context),
        trainingId: state.pathParameters['trainingId']!,
      ),
    ),
  ),
);
