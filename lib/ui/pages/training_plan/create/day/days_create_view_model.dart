import 'package:command_it/command_it.dart';
import 'package:flutter/widgets.dart';
import 'package:gymtrack/data/repositories/day/day_repository.dart';
import 'package:gymtrack/domain/models/day.dart';

class DaysCreateViewModel extends ChangeNotifier {
  final DayRepository _dayRepository;
  final String trainingPlanId;

  DaysCreateViewModel({
    required DayRepository dayRepository,
    required this.trainingPlanId,
  }) : _dayRepository = dayRepository {
    createDays = Command.createAsyncNoResult(_createDays);
  }

  late Command<List<Day>, void> createDays;

  Future<void> _createDays(List<Day> objs) async {
    if (objs.isEmpty) return;

    final result = await _dayRepository.saveDays(objs);

    if (result.isError()) throw Exception();
  }
}
