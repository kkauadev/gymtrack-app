import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:result_dart/result_dart.dart';

abstract class TrainingPlanRepository {
  Future<Result<List<TrainingPlan>>> getTrainingPlans(String userId);
  Future<Result<TrainingPlan>> getTrainingPlan(String trainingPlanId);
  Future<Result<Id>> saveTrainingPlan(TrainingPlan obj);
  Future<Result> deleteOne(String trainingPlanId);
}
