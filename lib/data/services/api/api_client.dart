import 'dart:convert';
import 'dart:io';

import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:result_dart/result_dart.dart';

List<TrainingPlan>? trainingPlans = [
  TrainingPlan(
    id: "019432b7-f196-702a-9dcb-99e7d8b0195d",
    name: "exemplo n1",
    userId: "1",
    observation: "Obs",
    pathology: "Patologia",
    timeInDays: 2,
    createdAt: DateTime.now(),
  ),
  TrainingPlan(
    id: "019432b8-3349-74b7-bc28-54a3f99c54d8",
    name: "exemplo n2",
    userId: "1",
    observation: "Obs",
    pathology: "Patologia",
    timeInDays: 2,
    createdAt: DateTime.now(),
  ),
  TrainingPlan(
    id: "019432b8-6a9c-75c0-ae91-125d0d1f7449",
    name: "exemplo n3",
    userId: "1",
    observation: "Obs",
    pathology: "Patologia",
    timeInDays: 2,
    createdAt: DateTime.now(),
  ),
];

List<Training>? trainings = [
  Training(
    id: "019432b9-0047-791f-a592-6632d051b5f3",
    trainingPlanId: "019432b7-f196-702a-9dcb-99e7d8b0195d",
    name: "exemplo n1",
    createdAt: DateTime.now(),
  ),
  Training(
    id: "019432b9-0047-791f-a592-6632d051b5f3",
    trainingPlanId: "019432b7-f196-702a-9dcb-99e7d8b0195d",
    name: "exemplo n1",
    createdAt: DateTime.now(),
  ),
  Training(
    id: "019432b9-cb24-7c3a-9a6d-f7898c8e5785",
    trainingPlanId: "019432b8-6a9c-75c0-ae91-125d0d1f7449",
    name: "exemplo n2",
    createdAt: DateTime.now(),
  )
];

List<Exercise>? exercises = [
  Exercise(
    id: "019432ba-0ad0-7741-a236-82eb52c3c0b3",
    trainingId: "019432b9-0047-791f-a592-6632d051b5f3",
    name: "exemplo n1",
    setsNumber: 15,
    repsNumber: 4,
    createdAt: DateTime.now(),
  ),
  Exercise(
    id: "019432ba-2220-7937-ad3d-876dd0905a1f",
    trainingId: "019432b9-cb24-7c3a-9a6d-f7898c8e5785",
    name: "exemplo n1",
    setsNumber: 15,
    repsNumber: 4,
    createdAt: DateTime.now(),
  )
];

class ApiClient {
  ApiClient({
    String? host,
    int? port,
    HttpClient Function()? clientFactory,
  })  : _host = host ?? 'localhost',
        _port = port ?? 8080,
        _clientFactory = clientFactory ?? (() => HttpClient());

  final String _host;
  final int _port;
  final HttpClient Function() _clientFactory;

  Future<Result<List<TrainingPlan>>> getTrainingPlans(String userId) async {
    await Future.delayed(Duration(milliseconds: 500));
    var a = trainingPlans?.where((t) => t.userId == userId);
    if (a != null) {
      return Success(a.toList());
    } else {
      return Failure(Exception());
    }

    return Success(trainingPlans!);
    final client = _clientFactory();
    try {
      final request = await client.get(_host, _port, '/training-plans');
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
    } catch (e) {
      return Failure(Exception(e));
    } finally {
      client.close();
    }
  }

  Future<Result<TrainingPlan>> getTrainingPlan(String trainingPlanId) async {
    await Future.delayed(Duration(milliseconds: 500));
    var a = trainingPlans?.where((t) => t.id == trainingPlanId).firstOrNull;
    if (a == null) {
      return Failure(Exception());
    } else {
      return Success(a);
    }
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

  Future<Result<List<Training>>> getTrainings(String trainingPlanId) async {
    await Future.delayed(Duration(milliseconds: 500));
    var a = trainings?.where((t) => t.trainingPlanId == trainingPlanId);
    if (a != null) {
      return Success(a.toList());
    } else {
      return Failure(Exception());
    }

    final client = _clientFactory();

    try {
      final request = await client.get(
        _host,
        _port,
        '/trainings/$trainingPlanId',
      );
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as List<dynamic>;
        return Success(
          json.map((element) => Training.fromJson(element)).toList(),
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

  Future<Result<List<Exercise>>> getExercises(String trainingId) async {
    await Future.delayed(Duration(milliseconds: 500));
    var a = exercises?.where((t) => t.trainingId == trainingId);
    if (a != null) {
      return Success(a.toList());
    } else {
      return Failure(Exception());
    }

    final client = _clientFactory();

    try {
      var request = await client.get(_host, _port, '/exercises');
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

  Future<Result<Id>> saveExercise(Exercise obj) async {
    exercises?.add(obj);

    await Future.delayed(Duration(milliseconds: 500));
    return Success(Id(value: obj.name));
  }

  Future<Result<Id>> saveTraining(Training obj) async {
    trainings?.add(obj);

    await Future.delayed(Duration(milliseconds: 500));
    return Success(Id(value: obj.name));
  }

  Future<Result<Id>> saveTrainingPlan(TrainingPlan obj) async {
    trainingPlans?.add(obj);

    await Future.delayed(Duration(milliseconds: 500));
    return Success(Id(value: obj.name));
    final client = _clientFactory();

    try {
      var request = await client.post(_host, _port, '/training-plan');
      var response = await request.close();

      if (response.statusCode == 200) {
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
    trainingPlans!.removeWhere((item) => item.id == trainingPlanId);
    await Future.delayed(Duration(milliseconds: 500));
    return Success({});
  }

  Future<Result> deleteOneTraining(String trainingId) async {
    trainings!.removeWhere((item) => item.id == trainingId);
    await Future.delayed(Duration(milliseconds: 500));
    return Success({});
  }

  Future<Result> deleteOneExercise(String exerciseId) async {
    exercises!.removeWhere((item) => item.id == exerciseId);
    await Future.delayed(Duration(minutes: 500));
    return Success({});
  }
}
