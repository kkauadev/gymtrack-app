import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:result_dart/result_dart.dart';

abstract class DayRepository {
  Future<Result<List<Day>>> getDays(String trainingPlanId);
  Future<Result<Id>> saveDay(Day obj);
  Future<Result> delete(String dayId);
}
