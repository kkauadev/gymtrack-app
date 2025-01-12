import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:result_dart/result_dart.dart';

class TrainingPlanRepositoryRemote implements TrainingPlanRepository {
  TrainingPlanRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<List<TrainingPlan>>> getTrainingPlans(String userId) async {
    final result = await _apiClient.getTrainingPlans(userId);

    return result;
  }

  @override
  Future<Result<TrainingPlan>> getTrainingPlan(String trainingPlanId) async {
    final result = await _apiClient.getTrainingPlan(trainingPlanId);

    return result;
  }

  @override
  Future<Result<Id>> saveTrainingPlan(TrainingPlan obj) async {
    final result = await _apiClient.saveTrainingPlan(obj);

    return result;
  }

  @override
  Future<Result> deleteOne(String trainingPlanId) async {
    final result = await _apiClient.deleteOneTrainingPlan(trainingPlanId);

    return result;
  }
}
