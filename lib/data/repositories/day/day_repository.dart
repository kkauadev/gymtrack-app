import 'package:gymtrack/data/services/api/model/day_api_model.dart';
import 'package:gymtrack/data/services/api/model/day_update_name.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:result_dart/result_dart.dart';

abstract class DayRepository {
  Future<Result<List<Day>>> getDays(String trainingPlanId);
  Future<Result<Id>> saveDay(Day obj);
  Future<Result> delete(String dayId);
  Future<Result<List<DayApiModel>>> getRecursiveDay(String trainingPlanId);
  Future<Result<DayApiModel>> getOneRecursiveDay(String dayId);
  Future<Result<String>> updateDayName(DayUpdateName data);
}
