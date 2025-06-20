import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gymtrack/data/services/api/model/day_api_model.dart';
import 'package:gymtrack/data/services/api/model/day_update_name.dart';
import 'package:gymtrack/data/services/api/model/exercise_with_day_api_mode.dart';
import 'package:gymtrack/data/services/auth_notifier_service.dart';
import 'package:gymtrack/domain/exceptions/exception.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:gymtrack/domain/models/user.dart';
import 'package:result_dart/result_dart.dart';

class ApiClient {
  ApiClient({
    required this.authNotifierService,
    String? host,
    int? port,
    HttpClient Function()? clientFactory,
  })  : _host = host ?? 'localhost',
        _port = port ?? 3000,
        _clientFactory = clientFactory ?? (() => HttpClient());

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;
  final AuthNotifierService authNotifierService;

  Future<Result<TrainingPlan>> getTrainingPlan(String trainingPlanId) async {
    return makeRequest<TrainingPlan>((client) async {
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
    });
  }

  Future<Result<List<TrainingPlan>>> getTrainingPlans(String userId) async {
    return makeRequest<List<TrainingPlan>>((client) async {
      final request =
          await client.get(_host, _port, '/training-plan/list/$userId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(
          json.map((element) => TrainingPlan.fromJson(element)).toList(),
        );
      } else {
        return Failure(HttpException("Invalid response"));
      }
    });
  }

  Future<Result<List<Exercise>>> getExercises(String dayId) async {
    return makeRequest<List<Exercise>>((client) async {
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
    });
  }

  Future<Result<List<Day>>> getDays(String trainingPlanId) async {
    return makeRequest<List<Day>>((client) async {
      final request =
          await client.get(_host, _port, '/day/list/$trainingPlanId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(json.map((element) => Day.fromJson(element)).toList());
      } else {
        return Failure(HttpException("Invalid response"));
      }
    });
  }

  Future<Result<Id>> saveExercise(Exercise obj) async {
    return makeRequest<Id>((client) async {
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
    });
  }

  Future<Result<Id>> saveExerciseWithDay(ExerciseWithDayApiMode obj) async {
    return makeRequest<Id>((client) async {
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
    });
  }

  Future<Result<Id>> saveTrainingPlan(TrainingPlan obj) async {
    return makeRequest<Id>((client) async {
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
    });
  }

  Future<Result<Id>> saveDay(Day obj) async {
    return makeRequest<Id>((client) async {
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
    });
  }

  Future<Result> deleteOneTrainingPlan(String trainingPlanId) async {
    return makeRequest((client) async {
      final req =
          await client.delete(_host, _port, '/training-plan/$trainingPlanId');
      final res = await req.close();

      return res.statusCode == 200
          ? Success("Success")
          : Failure(HttpException("Invalid response"));
    });
  }

  Future<Result> deleteDay(String dayId) async {
    return makeRequest((client) async {
      final req = await client.delete(_host, _port, '/day/$dayId');
      final res = await req.close();

      return res.statusCode == 200
          ? Success.unit()
          : Failure(HttpException("Invalid response"));
    });
  }

  Future<Result> deleteOneExercise(String exerciseId) async {
    return makeRequest((client) async {
      final req = await client.delete(_host, _port, '/exercise/$exerciseId');
      final res = await req.close();

      return res.statusCode == 200
          ? Success.unit()
          : Failure(HttpException("Invalid response"));
    });
  }

  Future<Result<List<DayApiModel>>> getRecursiveDay(
      String trainingPlanId) async {
    return makeRequest<List<DayApiModel>>((client) async {
      final request = await client.get(
          _host, _port, '/day/list/recursivaly/$trainingPlanId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(
          json.map((element) => DayApiModel.fromJson(element)).toList(),
        );
      } else {
        return Failure(HttpException("Invalid response"));
      }
    });
  }

  Future<Result<DayApiModel>> getOneRecursiveDay(String dayId) async {
    return makeRequest<DayApiModel>((client) async {
      final request = await client.get(_host, _port, '/day/recursivaly/$dayId');
      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData);
        return Success(DayApiModel.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    });
  }

  Future<Result<String>> updateDayName(DayUpdateName data) async {
    return makeRequest<String>((client) async {
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
    });
  }

  Future<Result<User>> getUser(String userId) async {
    return makeRequest<User>((client) async {
      final req = await client.get(_host, _port, 'user/$userId');

      final res = await req.close();
      if (res.statusCode == 200) {
        final stringData = await res.transform(utf8.decoder).join();
        final json = jsonDecode(stringData);
        return Success(User.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    });
  }

  Future<Result<User>> updateUser(User user) async {
    return makeRequest<User>((client) async {
      print("$_host/$_port/${user.id}");
      final req = await client.put(_host, _port, 'user/${user.id}');
      req.headers.contentType = ContentType.json;
      req.add(utf8.encode(jsonEncode(user.toJson())));

      final res = await req.close();
      if (res.statusCode == 200) {
        final stringData = await res.transform(utf8.decoder).join();
        final json = jsonDecode(stringData);
        return Success(User.fromJson(json));
      } else {
        return Failure(HttpException("Invalid response"));
      }
    });
  }

  Future<Result<T>> makeRequest<T extends Object>(
      Future<Result<T>> Function(HttpClient client) func) async {
    final client = _clientFactory();

    try {
      return await func(client);
    } on SocketException {
      return Failure(NetworkException());
    } on FormatException {
      return Failure(FormatException());
    } on TimeoutException {
      return Failure(TimeoutException("Tempo limite de conexão excedido."));
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }
}
