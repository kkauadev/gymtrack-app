import 'package:gymtrack/data/repositories/exercise/exercise_repository.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:result_dart/result_dart.dart';

class ExerciseRepositoryRemote implements ExerciseRepository {
  final ApiClient _apiClient;

  ExerciseRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<Result<List<Exercise>>> getExercises(String trainingId) async {
    var result = await _apiClient.getExercises(trainingId);

    return result;
  }

  @override
  Future<Result<Id>> saveExercise(Exercise obj) async {
    var result = await _apiClient.saveExercise(obj);

    return result;
  }

  @override
  Future<Result> deleteOne(String exerciseId) async {
    var result = await _apiClient.deleteOneExercise(exerciseId);

    return result;
  }
}
