import 'dart:convert';
import 'dart:io';

import 'package:gymtrack/data/services/api/model/day_api_model.dart';
import 'package:gymtrack/data/services/api/model/day_update_name.dart';
import 'package:gymtrack/data/services/api/model/exercise_with_day_api_mode.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:result_dart/result_dart.dart';

class ApiClient {
  ApiClient({
    String? host,
    int? port,
    HttpClient Function()? clientFactory,
  })  : _host = host ?? 'localhost',
        _port = port ?? 3000,
        _clientFactory = clientFactory ?? (() => HttpClient());

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;

  Future<Result<TrainingPlan>> getTrainingPlan(String trainingPlanId) async {
    final client = _clientFactory();
    try {
      final request =
          await client.get(_host, _port, '/training-plan/$trainingPlanId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as dynamic;
        return Success(
          TrainingPlan.fromJson(json),
        );
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<List<TrainingPlan>>> getTrainingPlans(String userId) async {
    final client = _clientFactory();
    try {
      final request =
          await client.get(_host, _port, '/training-plan/list/$userId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(
          json.map((element) {
            return TrainingPlan.fromJson(element);
          }).toList(),
        );
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<List<Exercise>>> getExercises(String dayId) async {
    final client = _clientFactory();

    try {
      var request = await client.get(_host, _port, '/exercise/list/$dayId');
      var response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(
          json.map((element) => Exercise.fromJson(element)).toList(),
        );
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<List<Day>>> getDays(String trainingPlanId) async {
    final client = _clientFactory();
    try {
      final request =
          await client.get(_host, _port, '/day/list/$trainingPlanId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(
          json.map((element) {
            return Day.fromJson(element);
          }).toList(),
        );
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<Id>> saveExercise(Exercise obj) async {
    final client = _clientFactory();

    try {
      var request = await client.post(_host, _port, '/exercise');
      request.headers.set(
        HttpHeaders.contentTypeHeader,
        'application/json; charset=utf-8',
      );
      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json; charset=utf-8',
      );
      request.add(utf8.encode(jsonEncode(obj.toJson())));

      var response = await request.close();

      if (response.statusCode == 201) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as dynamic;
        return Success(Id.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<Id>> saveExerciseWithDay(ExerciseWithDayApiMode obj) async {
    final client = _clientFactory();

    try {
      var request = await client.post(_host, _port, '/exercise');
      request.headers.set(
        HttpHeaders.contentTypeHeader,
        'application/json; charset=utf-8',
      );
      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json; charset=utf-8',
      );
      request.add(utf8.encode(jsonEncode(obj.toJson())));

      var response = await request.close();

      if (response.statusCode == 201) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as dynamic;
        return Success(Id.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<Id>> saveTrainingPlan(TrainingPlan obj) async {
    final client = _clientFactory();

    try {
      var request = await client.post(_host, _port, '/training-plan');
      request.headers.set(
        HttpHeaders.contentTypeHeader,
        'application/json; charset=utf-8',
      );
      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json; charset=utf-8',
      );
      request.add(utf8.encode(jsonEncode(obj.toJson())));

      var response = await request.close();

      if (response.statusCode == 201) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as dynamic;
        return Success(Id.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<Id>> saveDay(Day obj) async {
    final client = _clientFactory();

    try {
      var request = await client.post(_host, _port, '/day');
      request.headers.set(
        HttpHeaders.contentTypeHeader,
        'application/json; charset=utf-8',
      );
      request.headers.set(
        HttpHeaders.acceptHeader,
        'application/json; charset=utf-8',
      );
      request.add(utf8.encode(jsonEncode(obj.toJson())));

      var response = await request.close();

      if (response.statusCode == 201) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as dynamic;
        return Success(Id.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result> deleteOneTrainingPlan(String trainingPlanId) async {
    final client = _clientFactory();
    try {
      final req =
          await client.delete(_host, _port, '/training-plan/$trainingPlanId');
      final res = await req.close();

      return res.statusCode == 200
          ? Success("Success")
          : Failure(HttpException("Invalid response"));
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result> deleteDay(String dayId) async {
    final client = _clientFactory();
    try {
      final req = await client.delete(_host, _port, '/day/$dayId');
      final res = await req.close();

      return res.statusCode == 200
          ? Success("Success")
          : Failure(HttpException("Invalid response"));
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result> deleteOneExercise(String exerciseId) async {
    final client = _clientFactory();
    try {
      final req = await client.delete(_host, _port, '/exercise/$exerciseId');
      final res = await req.close();

      return res.statusCode == 200
          ? Success("Success")
          : Failure(HttpException("Invalid response"));
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<List<DayApiModel>>> getRecursiveDay(
      String trainingPlanId) async {
    final client = _clientFactory();
    try {
      final request = await client.get(
          _host, _port, '/day/list/recursivaly/$trainingPlanId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(
          json.map((element) {
            return DayApiModel.fromJson(element);
          }).toList(),
        );
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<DayApiModel>> getOneRecursiveDay(String dayId) async {
    final client = _clientFactory();
    try {
      final request = await client.get(_host, _port, '/day/recursivaly/$dayId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData);
        return Success(DayApiModel.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<String>> updateDayName(DayUpdateName data) async {
    final client = _clientFactory();
    try {
      final request =
          await client.put(_host, _port, '/day/update/name/${data.dayId}');
      request.add(utf8.encode(jsonEncode(data.toJson())));

      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData);
        return Success(json);
      } else {
        return Failure(HttpException("Invalid response"));
      }
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }
}
