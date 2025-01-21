import 'package:gymtrack/data/repositories/day/day_repository_remote.dart';
import 'package:gymtrack/data/repositories/exercise/exercise_repository_remote.dart';
import 'package:gymtrack/data/repositories/training/training_repository_remote.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//List<SingleChildWidget> _sharedProviders = [
//Provider(lazy: true,create: () => UseCase,)
//];

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => ApiClient()),
    Provider(
      create: (context) => TrainingPlanRepositoryRemote(
        apiClient: context.read(),
      ),
    ),
    Provider(
      create: (context) => DayRepositoryRemote(
        apiClient: context.read(),
      ),
    ),
    Provider(
      create: (context) => TrainingRepositoryRemote(
        apiClient: context.read(),
      ),
    ),
    Provider(
      create: (context) => ExerciseRepositoryRemote(
        apiClient: context.read(),
      ),
    )
  ];
}

List<SingleChildWidget> get providersLocal {
  return [];
}
