import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:gymtrack/data/repositories/plan_subscription/plan_subscription_repository.dart';
import 'package:gymtrack/domain/models/plan_subscription.dart';

class MySubscriptionsViewModel extends ChangeNotifier {
  final PlanSubscriptionRepository _planSubscriptionRepository;
  final String userId;

  MySubscriptionsViewModel({
    required PlanSubscriptionRepository planSubscriptionRepository,
    required this.userId,
  }) : _planSubscriptionRepository = planSubscriptionRepository {
    list = Command.createAsync(_list, initialValue: []);
    createPlanDayProgress = Command.createAsyncNoResult(_createPlanDayProgress);

    WidgetsBinding.instance.addPostFrameCallback((_) => list.execute(userId));
  }

  late Command<String, List<PlanSubscription>> list;
  late Command<Dto, void> createPlanDayProgress;

  Future<List<PlanSubscription>> _list(String userId) async {
    final result = await _planSubscriptionRepository.list(userId);

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
