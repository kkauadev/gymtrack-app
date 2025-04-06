import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingPlansListViewModel extends ChangeNotifier {
  final TrainingPlanRepository _trainingPlanRepository;
  final String userId;

  TrainingPlansListViewModel({
    required TrainingPlanRepository trainingPlanRepository,
    required this.userId,
  }) : _trainingPlanRepository = trainingPlanRepository {
    load = Command.createAsync(
      _load,
      initialValue: [],
    );
    deleteOne = Command.createAsync(_deleteOne, initialValue: null);
    deleteOne.addListener(() => load.execute(userId));

    WidgetsBinding.instance.addPostFrameCallback((_) => load.execute(userId));
  }

  late Command<String, List<TrainingPlan>> load;
  late Command<String, void> deleteOne;

  List<TrainingPlan> get trainingPlans => _trainingPlans;
  List<TrainingPlan> _trainingPlans = [];

  Future<List<TrainingPlan>> _load(String userId) async {
    final result = await _trainingPlanRepository.getTrainingPlans(userId);

    if (result.isSuccess()) {
      _trainingPlans = result.getOrDefault([]);
      return _trainingPlans;
    } else {
      throw Exception(result.exceptionOrNull()!);
    }
  }

  Future<void> _deleteOne(String trainingPlanId) async {
    final result = await _trainingPlanRepository.deleteOne(trainingPlanId);

    if (result.isError()) {
      throw Exception(result.exceptionOrNull()!);
    }
  }
}
