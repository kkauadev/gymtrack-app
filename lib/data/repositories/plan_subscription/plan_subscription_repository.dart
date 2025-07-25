import 'package:gymtrack/domain/models/plan_subscription.dart';
import 'package:result_dart/result_dart.dart';

abstract class PlanSubscriptionRepository {
  Future<Result<List<PlanSubscription>>> list(String userId);
  Future<Result> createSubscription(String trainingPlanId, String userId);
  Future<Result<bool>> exists(String trainingPlanId, String userId);
  Future<Result> createPlanDayProgress(
      String planSubscriptionId, String userId);
}
