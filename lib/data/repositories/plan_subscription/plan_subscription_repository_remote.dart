import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/domain/models/plan_subscription.dart';
import 'package:result_dart/result_dart.dart';

class PlanSubscriptionRepositoryRemote implements PlanSubscriptionRepository {
  final ApiClient _apiClient;

  PlanSubscriptionRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<Result<List<PlanSubscription>>> list(String userId) async {
    var result = _apiClient.getPlanSubscriptions(userId);
    return result;
  }

  @override
  Future<Result<Object>> createSubscription(
    String trainingPlanId,
    String userId,
  ) {
    var result = _apiClient.createSubscription(trainingPlanId, userId);
    return result;
  }

  @override
  Future<Result<bool>> exists(String trainingPlanId, String userId) {
    var result = _apiClient.existsPlanSubscription(trainingPlanId, userId);
    return result;
  }

  @override
  Future<Result<Object>> createPlanDayProgress(
      String planSubscriptionId, String userId) {
    var result = _apiClient.createPlanDayProgress(planSubscriptionId, userId);
    return result;
  }
}
