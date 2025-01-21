import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/exercise/exercise_repository.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';

class ExerciseListViewModel extends ChangeNotifier {
  final ExerciseRepository _exerciseRepository;
  final String trainingId;

  ExerciseListViewModel({
    required ExerciseRepository exerciseRepository,
    required this.trainingId,
  }) : _exerciseRepository = exerciseRepository {
    load = Command.createAsync(_load, initialValue: []);
    saveExercise = Command.createAsync(
      _saveExercise,
      initialValue: null,
    );
    deleteOneExercise = Command.createAsync(_deleteOne, initialValue: null);

    saveExercise.addListener(() => load.execute(trainingId));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load.execute(trainingId);
    });
  }

  late Command<String, List<Exercise>> load;
  late Command<Exercise, Id?> saveExercise;
  late Command<String, void> deleteOneExercise;

  Future<List<Exercise>> _load(String trainingId) async {
    var result = await _exerciseRepository.getExercises(trainingId);

    if (result.isSuccess()) {
      return result.getOrDefault([]);
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<Id?> _saveExercise(Exercise obj) async {
    final result = await _exerciseRepository.saveExercise(obj);

    if (result.isSuccess()) {
      return result.getOrNull();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<void> _deleteOne(String exerciseId) async {
    final result = await _exerciseRepository.deleteOne(exerciseId);

    if (result.isError()) throw Exception(result.exceptionOrNull());
  }
}
