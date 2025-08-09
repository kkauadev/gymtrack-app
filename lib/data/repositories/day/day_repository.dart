import 'package:gymtrack/data/services/api/model/day_update_name.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:result_dart/result_dart.dart';

abstract class DayRepository {
  Future<Result<List<Day>>> getDays(String trainingPlanId);
  Future<Result> saveDay(Day obj);
  Future<Result> saveDays(List<Day> objs);
  Future<Result> delete(String dayId);
  Future<Result<String>> updateDayName(DayUpdateName data);
}
