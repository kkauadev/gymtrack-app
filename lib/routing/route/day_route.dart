import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/day/day_repository_remote.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/day/list/view_models/day_list_view_model.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/day_list_screen.dart';
import 'package:provider/provider.dart';

GoRoute dayRoute = GoRoute(
  path: Routes.build(
    path: "/day",
    method: "/list",
    param: "/:trainingPlanId",
  ),
  pageBuilder: (context, state) => NoTransitionPage(
    child: DayListScreen(
      viewModel: DayListViewModel(
        dayRepository: Provider.of<DayRepositoryRemote>(context),
        trainingPlanRepository: Provider.of<TrainingPlanRepositoryRemote>(
          context,
        ),
        trainingPlanId: state.pathParameters['trainingPlanId']!,
      ),
    ),
  ),
);
