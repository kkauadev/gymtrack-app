import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/data/repositories/exercise/exercise_repository.dart';
import 'package:gymtrack/data/services/api/model/exercise_with_day_api_mode.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';

class ExerciseListViewModel extends ChangeNotifier {
  final ExerciseRepository _exerciseRepository;
  final String dayId;

  ExerciseListViewModel({
    required ExerciseRepository exerciseRepository,
    required this.dayId,
  }) : _exerciseRepository = exerciseRepository {
    load = Command.createAsync(_load, initialValue: []);
    saveExercise = Command.createAsync(
      _saveExercise,
      initialValue: null,
    );
    saveExerciseWithDay = Command.createAsync(
      _saveExerciseWithDay,
      initialValue: null,
    );
    deleteOneExercise = Command.createAsync(_deleteOne, initialValue: null);

    saveExercise.addListener(() => load.execute(dayId));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load.execute(dayId);
    });
  }

  late Command<String, List<Exercise>> load;
  late Command<Exercise, Id?> saveExercise;
  late Command<String, void> deleteOneExercise;
  late Command<ExerciseWithDayApiMode, Id?> saveExerciseWithDay;

  Future<List<Exercise>> _load(String dayId) async {
    var result = await _exerciseRepository.getExercises(dayId);

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

  Future<Id?> _saveExerciseWithDay(ExerciseWithDayApiMode obj) async {
    final result = await _exerciseRepository.saveExerciseWithDay(obj);

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
