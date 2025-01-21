import 'package:gymtrack/data/repositories/day/day_repository.dart';
import 'package:gymtrack/data/services/api/api_client.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:result_dart/result_dart.dart';

class DayRepositoryRemote extends DayRepository {
  final ApiClient _apiClient;

  DayRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Result<List<Day>>> getDays(String trainingPlanId) async {
    var result = await _apiClient.getDays(trainingPlanId);
    return result;
  }

  @override
  Future<Result<Id>> saveDay(Day obj) async {
    var result = await _apiClient.saveDay(obj);
    return result;
  }

  @override
  Future<Result<Object>> delete(String dayId) async {
    return await _apiClient.deleteDay(dayId);
  }
}
