import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training.dart';
import 'package:result_dart/result_dart.dart';

abstract class TrainingRepository {
  Future<Result<List<Training>>> getTrainings(String trainingPlanId);
  Future<Result<Id>> saveTraining(Training obj);
  Future<Result> deleteOne(String trainingId);
}
