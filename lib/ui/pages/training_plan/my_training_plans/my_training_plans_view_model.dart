import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class MyTrainingPlansViewModel extends ChangeNotifier {
  final TrainingPlanRepository _trainingPlanRepository;
  final String userId;

  MyTrainingPlansViewModel({
    required TrainingPlanRepository trainingPlanRepository,
    required this.userId,
  }) : _trainingPlanRepository = trainingPlanRepository {
    load = Command.createAsyncNoParam(
      _load,
      initialValue: [],
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => load.execute());
  }
  late Command<void, List<TrainingPlan>> load;

  Future<List<TrainingPlan>> _load() async {
    final result =
        await _trainingPlanRepository.getTrainingPlansByUserId(userId);

    if (result.isSuccess()) {
      return result.getOrDefault([]);
    } else {
      throw Exception(result.exceptionOrNull()!);
    }
  }
}
