import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/domain/models/plan_subscription.dart';

class MySubscriptionsViewModel extends ChangeNotifier {
  final PlanSubscriptionRepository _planSubscriptionRepository;
  final AuthNotifierService _authNotifierService;

  MySubscriptionsViewModel({
    required PlanSubscriptionRepository planSubscriptionRepository,
    required AuthNotifierService authNotifierService,
  })  : _planSubscriptionRepository = planSubscriptionRepository,
        _authNotifierService = authNotifierService {
    list = Command.createAsyncNoParam(_list, initialValue: []);
    createPlanDayProgress = Command.createAsyncNoResult(_createPlanDayProgress);

    WidgetsBinding.instance.addPostFrameCallback((_) => list.execute());
  }

  late Command<void, List<PlanSubscription>> list;
  late Command<Dto, void> createPlanDayProgress;

  Future<List<PlanSubscription>> _list() async {
    var userId = await _authNotifierService.getUserId();
    final result = await _planSubscriptionRepository.list(userId!);

    if (result.isSuccess()) {
      return result.getOrThrow();
    } else {
      throw Exception();
    }
  }

  Future _createPlanDayProgress(Dto dto) async {
    final result = await _planSubscriptionRepository.createPlanDayProgress(
      dto.planSubscriptionId,
      dto.dayId,
    );

    if (result.isError()) {
      throw Exception();
    }
  }
}

class Dto {
  final String planSubscriptionId;
  final String dayId;

  Dto({required this.planSubscriptionId, required this.dayId});
}
