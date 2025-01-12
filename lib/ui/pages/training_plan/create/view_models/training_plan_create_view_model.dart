import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingPlanCreateViewModel {
  final TrainingPlanRepository _trainingPlanRepository;
  final String userId;

  TrainingPlanCreateViewModel({
    required TrainingPlanRepository trainingPlanRepository,
    required this.userId,
  }) : _trainingPlanRepository = trainingPlanRepository {
    saveTrainingPlan = Command.createAsync(
      _saveExercise,
      initialValue: null,
    );
  }

  late Command<TrainingPlan, Id?> saveTrainingPlan;

  Future<Id?> _saveExercise(TrainingPlan obj) async {
    final result = await _trainingPlanRepository.saveTrainingPlan(obj);

    if (result.isSuccess()) {
      return result.getOrNull();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }
}
