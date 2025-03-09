import 'package:gymtrack/data/repositories/exercise/exercise_repository.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/data/services/api/model/exercise_with_day_api_mode.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:result_dart/result_dart.dart';

class ExerciseRepositoryRemote implements ExerciseRepository {
  final ApiClient _apiClient;

  ExerciseRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<Result<List<Exercise>>> getExercises(String dayId) async {
    var result = await _apiClient.getExercises(dayId);

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

  @override
  Future<Result<Id>> saveExerciseWithDay(ExerciseWithDayApiMode obj) async {
    var result = await _apiClient.saveExerciseWithDay(obj);

    return result;
  }
}
