import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/day/day_repository.dart';
import 'package:gymtrack/data/repositories/exercise/exercise_repository.dart';
import 'package:gymtrack/data/services/api/model/day_api_model.dart';
import 'package:gymtrack/data/services/api/model/day_update_name.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';

class DayViewModel extends ChangeNotifier {
  final DayRepository _dayRepository;
  final ExerciseRepository _exerciseRepository;
  final String dayId;

  DayViewModel({
    required DayRepository dayRepository,
    required ExerciseRepository exerciseRepository,
    required this.dayId,
  })  : _dayRepository = dayRepository,
        _exerciseRepository = exerciseRepository {
    load = Command.createAsync(_load, initialValue: null);
    saveExercise = Command.createAsync(_saveExercise, initialValue: null);
    deleteExercise = Command.createAsync(_deleteExercise, initialValue: null);
    updateDayName = Command.createAsync(_updateDayName, initialValue: "");

    saveExercise.addListener(() => load(dayId));
    deleteExercise.addListener(() => load(dayId));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load.execute(dayId);
    });
  }

  late Command<String, DayApiModel?> load;
  late Command<Exercise, Id?> saveExercise;
  late Command<String, void> deleteExercise;
  late Command<DayUpdateName, String> updateDayName;

  Future<DayApiModel> _load(String dayId) async {
    var result = await _dayRepository.getOneRecursiveDay(dayId);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception();
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

  Future<void> _deleteExercise(String exerciseId) async {
    final result = await _exerciseRepository.deleteOne(exerciseId);

    if (result.isError()) throw Exception(result.exceptionOrNull());
  }

  Future<String> _updateDayName(DayUpdateName data) async {
    final result = await _dayRepository.updateDayName(data);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }
}
