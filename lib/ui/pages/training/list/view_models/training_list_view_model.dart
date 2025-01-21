import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/repositories/training/training_repository.dart';
import 'package:gymtrack/domain/models/id.dart';
import 'package:gymtrack/domain/models/training.dart';

class TrainingListViewModel extends ChangeNotifier {
  final TrainingRepository _trainingRepository;
  final String dayId;

  TrainingListViewModel({
    required TrainingRepository trainingRepository,
    required this.dayId,
  }) : _trainingRepository = trainingRepository {
    loadTrainings = Command.createAsync(_loadTrainings, initialValue: []);
    saveTraining = Command.createAsync(_saveTraining, initialValue: null);
    deleteTraining = Command.createAsync(_deleteOne, initialValue: null);

    saveTraining.addListener(() => loadTrainings.execute(dayId));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadTrainings.execute(dayId);
    });
  }

  late Command<String, List<Training>> loadTrainings;
  late Command<Training, Id?> saveTraining;
  late Command<String, void> deleteTraining;

  Future<List<Training>> _loadTrainings(String dayId) async {
    final result = await _trainingRepository.getTrainings(dayId);

    if (result.isSuccess()) {
      return result.getOrDefault([]);
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<Id?> _saveTraining(Training obj) async {
    final result = await _trainingRepository.saveTraining(obj);

    if (result.isSuccess()) {
      return result.getOrNull();
    } else {
      throw Exception(result.exceptionOrNull());
    }
  }

  Future<void> _deleteOne(String trainingId) async {
    final result = await _trainingRepository.deleteOne(trainingId);

    if (result.isError()) throw Exception(result.exceptionOrNull());
  }
}
