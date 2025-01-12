import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/training/training_repository.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingListViewModel extends ChangeNotifier {
  final TrainingPlanRepository _trainingPlanRepository;
  final TrainingRepository _trainingRepository;
  final String trainingPlanId;

  TrainingListViewModel({
    required TrainingRepository trainingRepository,
    required TrainingPlanRepository trainingPlanRepository,
    required this.trainingPlanId,
  })  : _trainingRepository = trainingRepository,
        _trainingPlanRepository = trainingPlanRepository {
    loadTrainings = Command.createAsync(_loadTrainings, initialValue: []);
    loadTrainingPlan = Command.createAsync(
      _loadTrainingPlan,
      initialValue: null,
    );
    saveTraining = Command.createAsync(_saveTraining, initialValue: null);
    deleteTraining = Command.createAsync(_deleteOne, initialValue: null);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTrainings.execute(trainingPlanId);
      loadTrainingPlan.execute(trainingPlanId);
    });
  }

  late Command<String, List<Training>> loadTrainings;
  late Command<String, TrainingPlan?> loadTrainingPlan;
  late Command<Training, Id?> saveTraining;
  late Command<String, void> deleteTraining;

  Future<List<Training>> _loadTrainings(String trainingPlanId) async {
    final result = await _trainingRepository.getTrainings(trainingPlanId);

    if (result.isSuccess()) {
      return result.getOrDefault([]);
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<TrainingPlan> _loadTrainingPlan(String trainingPlanId) async {
    final result = await _trainingPlanRepository.getTrainingPlan(
      trainingPlanId,
    );

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<Id?> _saveTraining(Training obj) async {
    final result = await _trainingRepository.saveTraining(obj);

    if (result.isSuccess()) {
      return result.getOrNull();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<void> _deleteOne(String trainingId) async {
    final result = await _trainingRepository.deleteOne(trainingId);

    if (result.isError()) throw Exception(result.exceptionOrNull());
  }
}
