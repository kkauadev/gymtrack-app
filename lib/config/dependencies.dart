import 'package:gymtrack/data/repositories/auth/auth_repository_remote.dart';
import 'package:gymtrack/data/repositories/day/day_repository_remote.dart';
import 'package:gymtrack/data/repositories/exercise/exercise_repository_remote.dart';
import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository_remote.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository_remote.dart';
import 'package:gymtrack/data/repositories/user/user_repository_remote.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/data/services/api/auth_api_client.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersRemote {
  return [
    ChangeNotifierProvider(create: (context) => AuthNotifierService()),
    Provider(
        create: (context) => ApiClient(authNotifierService: context.read())),
    Provider(create: (context) => AuthApiClient()),
    Provider(
      create: (context) => AuthRepositoryRemote(
          apiClient: context.read(), authNotifierService: context.read()),
    ),
    Provider(
      create: (context) => UserRepositoryRemote(apiClient: context.read()),
    ),
    Provider(
      create: (context) => TrainingPlanRepositoryRemote(
        apiClient: context.read(),
      ),
    ),
    Provider(
      create: (context) => DayRepositoryRemote(apiClient: context.read()),
    ),
    Provider(
      create: (context) => ExerciseRepositoryRemote(apiClient: context.read()),
    ),
    Provider(
      create: (context) => PlanSubscriptionRepositoryRemote(
        apiClient: context.read(),
      ),
    )
  ];
}

List<SingleChildWidget> get providersLocal {
  return [];
}
