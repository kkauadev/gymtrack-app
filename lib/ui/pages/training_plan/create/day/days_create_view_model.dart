import 'package:command_it/command_it.dart';
import 'package:flutter/widgets.dart';
import 'package:gymtrack/data/repositories/day/day_repository.dart';
import 'package:gymtrack/domain/models/day.dart';

class DaysCreateViewModel extends ChangeNotifier {
  final DayRepository _dayRepository;

  DaysCreateViewModel(DayRepository dayRepository)
      : _dayRepository = dayRepository {
    create = Command.createAsyncNoResult(_create);
  }

  late Command<Day, void> create;

  Future<void> _create(Day obj) async {
    final result = await _dayRepository.saveDay(obj);

    if (result.isError()) throw Exception();
  }
}
