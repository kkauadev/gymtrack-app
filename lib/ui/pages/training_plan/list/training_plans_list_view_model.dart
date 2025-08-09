import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingPlansListViewModel extends ChangeNotifier {
  final TrainingPlanRepository _trainingPlanRepository;

  TrainingPlansListViewModel(
      {required TrainingPlanRepository trainingPlanRepository})
      : _trainingPlanRepository = trainingPlanRepository {
    load = Command.createAsyncNoParam(
      _load,
      initialValue: [],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => load.execute());
  }

  late Command<void, List<TrainingPlan>> load;

  List<TrainingPlan> get trainingPlans => _trainingPlans;
  List<TrainingPlan> _trainingPlans = [];

  Future<List<TrainingPlan>> _load() async {
    final result = await _trainingPlanRepository.getTrainingPlans();

    if (result.isSuccess()) {
      _trainingPlans = result.getOrDefault([]);
      return _trainingPlans;
    } else {
      throw Exception(result.exceptionOrNull()!);
    }
  }
}
