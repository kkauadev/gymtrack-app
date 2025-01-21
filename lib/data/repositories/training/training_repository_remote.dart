import 'package:gymtrack/data/repositories/training/training_repository.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training.dart';
import 'package:result_dart/result_dart.dart';

class TrainingRepositoryRemote implements TrainingRepository {
  TrainingRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<Result<List<Training>>> getTrainings(String dayId) async {
    final result = await _apiClient.getTrainings(dayId);

    return result;
  }

  @override
  Future<Result<Id>> saveTraining(Training obj) async {
    final result = await _apiClient.saveTraining(obj);

    return result;
  }

  @override
  Future<Result> deleteOne(String trainingId) async {
    final result = await _apiClient.deleteOneTraining(trainingId);

    return result;
  }
}
