import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:result_dart/result_dart.dart';

abstract class ExerciseRepository {
  Future<Result<List<Exercise>>> getExercises(String trainingId);
  Future<Result<Id>> saveExercise(Exercise obj);
  Future<Result> deleteOne(String exerciseId);
}
