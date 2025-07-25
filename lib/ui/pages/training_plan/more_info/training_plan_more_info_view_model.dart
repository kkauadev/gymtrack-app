import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingPlanMoreInfoViewModel extends ChangeNotifier {
  final TrainingPlanRepository _trainingPlanRepository;
  final PlanSubscriptionRepository _planSubscriptionRepository;
  final String userId;
  final String trainingPlanId;

  TrainingPlanMoreInfoViewModel(
      {required TrainingPlanRepository trainingPlanRepository,
      required PlanSubscriptionRepository planSubscriptionRepository,
      required this.userId,
      required this.trainingPlanId})
      : _trainingPlanRepository = trainingPlanRepository,
        _planSubscriptionRepository = planSubscriptionRepository {
    get = Command.createAsync(_get, initialValue: null);
    createSubscription =
        Command.createAsyncNoParamNoResult(_createSubscription);
    existsPlanSubscription = Command.createAsyncNoParam(
      _existsPlanSubscription,
      initialValue: false,
    );

    WidgetsBinding.instance
        .addPostFrameCallback((_) => get.execute(trainingPlanId));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => existsPlanSubscription.execute());
  }

  late Command<String, TrainingPlan?> get;
  late Command<void, bool> existsPlanSubscription;
  late Command<void, void> createSubscription;

  Future<TrainingPlan> _get(String trainingPlanId) async {
    final result =
        await _trainingPlanRepository.getTrainingPlan(trainingPlanId);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception();
    }
  }

  Future<void> _createSubscription() async {
    final result = await _planSubscriptionRepository.createSubscription(
      trainingPlanId,
      userId,
    );

    if (!result.isSuccess()) {
      throw Exception();
    }
  }

  Future<bool> _existsPlanSubscription() async {
    final result =
        await _planSubscriptionRepository.exists(trainingPlanId, userId);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception();
    }
  }
}
