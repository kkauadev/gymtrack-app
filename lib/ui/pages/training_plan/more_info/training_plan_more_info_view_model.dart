import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository.dart';
import 'package:gymtrack/data/repositories/trainingplan/training_plan_repository.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingPlanMoreInfoViewModel extends ChangeNotifier {
  final TrainingPlanRepository _trainingPlanRepository;
  final PlanSubscriptionRepository _planSubscriptionRepository;
  final AuthNotifierService _authNotifierService;
  final String trainingPlanId;

  TrainingPlanMoreInfoViewModel(
      {required TrainingPlanRepository trainingPlanRepository,
      required PlanSubscriptionRepository planSubscriptionRepository,
      required AuthNotifierService authNotifierService,
      required this.trainingPlanId})
      : _trainingPlanRepository = trainingPlanRepository,
        _planSubscriptionRepository = planSubscriptionRepository,
        _authNotifierService = authNotifierService {
    get = Command.createAsync(_get, initialValue: null);
    createSubscription =
        Command.createAsyncNoParamNoResult(_createSubscription);
    existsPlanSubscription = Command.createAsyncNoParam(
      _existsPlanSubscription,
      initialValue: false,
    );
    existsPlanSubscriptionInProgress = Command.createAsyncNoParam(
      _existsPlanSubscriptionInProgress,
      initialValue: false,
    );
    sendPlanSubscriptionToInProgress =
        Command.createAsyncNoParamNoResult(_sendPlanSubscriptionToInProgress);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => get.execute(trainingPlanId));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => existsPlanSubscription.execute());
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => existsPlanSubscriptionInProgress.execute());
  }

  late Command<String, TrainingPlan?> get;
  late Command<void, bool> existsPlanSubscription;
  late Command<void, void> createSubscription;
  late Command<void, bool> existsPlanSubscriptionInProgress;
  late Command<void, void> sendPlanSubscriptionToInProgress;

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
    var userId = await _authNotifierService.getUserId();

    final result = await _planSubscriptionRepository.createSubscription(
      trainingPlanId,
      userId!,
    );

    if (!result.isSuccess()) {
      throw Exception();
    }
  }

  Future<bool> _existsPlanSubscription() async {
    var userId = await _authNotifierService.getUserId();

    final result =
        await _planSubscriptionRepository.exists(trainingPlanId, userId!);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception();
    }
  }

  Future<bool> _existsPlanSubscriptionInProgress() async {
    var userId = await _authNotifierService.getUserId();

    final result = await _planSubscriptionRepository.existsInProgress(
        trainingPlanId, userId!);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception();
    }
  }

  Future _sendPlanSubscriptionToInProgress() async {
    var userId = await _authNotifierService.getUserId();

    final result = await _planSubscriptionRepository.sendToInProgress(
        trainingPlanId, userId!);

    if (result.isError()) {
      throw Exception();
    }
  }
}
