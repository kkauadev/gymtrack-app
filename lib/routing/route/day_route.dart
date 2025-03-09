import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/repositories/day/day_repository_remote.dart';
import 'package:gymtrack/data/repositories/exercise/exercise_repository_remote.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/day/list/view_models/day_list_view_model.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/day_list_screen.dart';
import 'package:gymtrack/ui/pages/day/one/view_models/day_view_model.dart';
import 'package:gymtrack/ui/pages/day/one/widgets/day_screen.dart';
import 'package:provider/provider.dart';

GoRoute dayRoute = GoRoute(
    path: Routes.build(
      path: "/day",
    ),
    pageBuilder: (context, state) => NoTransitionPage(child: Text("data")),
    routes: [
      GoRoute(
        path: "/:dayId",
        pageBuilder: (context, state) => NoTransitionPage(
          child: DayScreen(
            viewModel: DayViewModel(
              dayRepository: Provider.of<DayRepositoryRemote>(context),
              exerciseRepository: Provider.of<ExerciseRepositoryRemote>(
                context,
              ),
              dayId: state.pathParameters['dayId']!,
            ),
          ),
        ),
      ),
      GoRoute(
        path: "/:trainingPlanId/list",
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
      )
    ]);
