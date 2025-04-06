import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/day/day_repository.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/data/services/api/model/day_api_model.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class DayListViewModel extends ChangeNotifier {
  final TrainingPlanRepository _trainingPlanRepository;
  final DayRepository _dayRepository;
  final String trainingPlanId;

  DayListViewModel({
    required TrainingPlanRepository trainingPlanRepository,
    required DayRepository dayRepository,
    required this.trainingPlanId,
  })  : _trainingPlanRepository = trainingPlanRepository,
        _dayRepository = dayRepository {
    loadTrainingPlan = Command.createAsync(
      _loadTrainingPlan,
      initialValue: null,
    );
    saveDay = Command.createAsync(_saveDay, initialValue: null);
    deleteDay = Command.createAsync(_deleteDay, initialValue: null);
    loadRecursiveDay = Command.createAsync(_loadRecursiveDay, initialValue: []);

    saveDay.addListener(() {
      loadRecursiveDay.execute(trainingPlanId);
    });
    deleteDay.addListener(() => loadRecursiveDay.execute(trainingPlanId));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTrainingPlan.execute(trainingPlanId);
      loadRecursiveDay.execute(trainingPlanId);
    });
  }

  late Command<String, TrainingPlan?> loadTrainingPlan;
  late Command<Day, Id?> saveDay;
  late Command<String, void> deleteDay;
  late Command<String, List<DayApiModel>> loadRecursiveDay;

  Future<TrainingPlan> _loadTrainingPlan(String dayId) async {
    final result = await _trainingPlanRepository.getTrainingPlan(
      dayId,
    );

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<Id> _saveDay(Day obj) async {
    final result = await _dayRepository.saveDay(obj);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<void> _deleteDay(String dayId) async {
    final result = await _dayRepository.delete(dayId);

    if (result.isError()) {
      throw Exception(result.exceptionOrNull);
    }
  }

  Future<List<DayApiModel>> _loadRecursiveDay(String trainingPlanId) async {
    final result = await _dayRepository.getRecursiveDay(trainingPlanId);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }
}
