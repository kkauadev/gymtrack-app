import 'package:command_it/command_it.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingPlanCreateViewModel {
  final TrainingPlanRepository _trainingPlanRepository;
  final AuthNotifierService _authNotifierService;

  TrainingPlanCreateViewModel({
    required TrainingPlanRepository trainingPlanRepository,
    required AuthNotifierService authNotifierService,
  })  : _trainingPlanRepository = trainingPlanRepository,
        _authNotifierService = authNotifierService {
    saveTrainingPlan = Command.createAsync(
      _saveTrainingPlan,
      initialValue: null,
    );
    getUserId = Command.createAsyncNoParam(_getUserId, initialValue: "");
  }

  late Command<TrainingPlan, Id?> saveTrainingPlan;
  late Command<void, String> getUserId;

  Future<Id?> _saveTrainingPlan(TrainingPlan obj) async {
    final result = await _trainingPlanRepository.saveTrainingPlan(obj);

    if (result.isSuccess()) {
      return result.getOrNull();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<String> _getUserId() async {
    return await _authNotifierService.getUserId() ?? "";
  }
}
