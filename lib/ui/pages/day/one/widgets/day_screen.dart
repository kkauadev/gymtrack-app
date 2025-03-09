import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/data/services/api/model/day_api_model.dart';
import 'package:gymtrack/data/services/api/model/day_update_name.dart';
import 'package:gymtrack/ui/core/widgets/modal_builder.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/a.dart';
import 'package:gymtrack/ui/pages/day/one/view_models/day_view_model.dart';
import 'package:gymtrack/ui/pages/day/one/widgets/create_exercise_modal.dart';

class DayScreen extends StatefulWidget {
  const DayScreen({super.key, required this.viewModel});

  final DayViewModel viewModel;

  @override
  State<StatefulWidget> createState() => DayScreenState();
}

class DayScreenState extends State<DayScreen> {
  bool _showEditOptions = false;
  final TextEditingController _textController = TextEditingController();
  String _currentText = "";

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  onPressEditButton() => setState(() => _showEditOptions = !_showEditOptions);
  onPressAddButton() {
    return dialogBuilder(
      context,
      title: "Novo Exercicio",
      content: CreateExerciseModal(
        viewModel: widget.viewModel,
        dayId: widget.viewModel.dayId,
        onPressFinish: () => Navigator.of(context).pop(),
      ),
    );
  }

  onPressUpdateDayName(String dayId, String oldValue) {
    final inputText = _textController.text;

    if (inputText.isNotEmpty && oldValue != inputText) {
      widget.viewModel.updateDayName(DayUpdateName(
        dayId: dayId,
        name: inputText,
      ));
    }
  }

  onPressExerciseRow(ExerciseApiModel exercise) {
    return dialogBuilder(
      context,
      title: "Novo Exercicio",
      content: CreateExerciseModal(
        viewModel: widget.viewModel,
        dayId: widget.viewModel.dayId,
        onPressFinish: () => Navigator.of(context).pop(),
        name: exercise.name,
        description: exercise.description,
        level: "1",
        observation: exercise.observation,
        repsNumber: exercise.repsNumber,
        setsNumber: exercise.setsNumber,
      ),
    );
  }

  onPressedConfirmEditDayTitle() {
    setState(() {
      _currentText = _textController.text;
      _showEditOptions = false;
    });
  }

  onPressedCancelEditDayTitle() => setState(() => _showEditOptions = false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(size: 36),
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined),
            onPressed: onPressEditButton,
          ),
          IconButton(
            icon: Icon(Icons.add_outlined),
            onPressed: onPressAddButton,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CommandBuilder(
            command: widget.viewModel.load,
            onData: (context, data, param) {
              _currentText = data!.name;
              _textController.text = _currentText;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_showEditOptions) ...[
                            Expanded(
                              child: TextField(
                                controller: _textController,
                                decoration: InputDecoration(
                                  hintText: "Digite o novo texto",
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  onPressUpdateDayName(data.id, data.name),
                              icon: Icon(Icons.check, size: 36),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            IconButton(
                              onPressed: onPressedCancelEditDayTitle,
                              icon: Icon(
                                Icons.close,
                                size: 36,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ] else
                            Expanded(
                              child: Text(
                                _currentText,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.exercises.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12),
                          itemBuilder: (_, idx) {
                            if (data.exercises.isEmpty) {
                              return const Text("Lista vazia");
                            }

                            var exercise = data.exercises[idx];
                            return Dismissible(
                              key: Key(exercise.name),
                              direction: DismissDirection.horizontal,
                              onDismissed: (direction) =>
                                  widget.viewModel.deleteExercise(exercise.id),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              child: GestureDetector(
                                onTap: () => onPressExerciseRow(exercise),
                                child: ExerciseRow(exercise: exercise),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
