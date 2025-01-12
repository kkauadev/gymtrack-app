import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/ui/core/widgets/default_loading.dart';
import 'package:gymtrack/ui/pages/exercise/list/view_models/exercise_list_view_model.dart';
import 'package:gymtrack/ui/core/widgets/modal_builder.dart';
import 'package:gymtrack/ui/pages/exercise/list/widgets/create_exercise_modal.dart';
import 'package:gymtrack/ui/pages/exercise/list/widgets/exercise_info_card.dart';

class ExerciceListScreen extends StatefulWidget {
  const ExerciceListScreen({super.key, required this.viewModel});

  final ExerciseListViewModel viewModel;

  @override
  State<StatefulWidget> createState() => ExerciceListScreenState();
}

class ExerciceListScreenState extends State<ExerciceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Treino de Peito",
          maxLines: 1,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CommandBuilder(
              command: widget.viewModel.load,
              whileExecuting: (context, lastValue, param) => DefaultLoading(),
              onData: (context, data, param) => Expanded(
                child: ListView.builder(
                  itemCount: data.length + 1,
                  itemBuilder: (context, index) {
                    if (index < data.length) {
                      return ExerciseInfoCard(
                        name: data[index].name,
                        description: data[index].description,
                        numberOfReps: data[index].repsNumber,
                        numberOfSets: data[index].setsNumber,
                        type: "Azul",
                        notes: "dasdas",
                        onTapDelete: () {
                          widget.viewModel.deleteOneExercise(data[index].id);
                          widget.viewModel.load(widget.viewModel.trainingId);
                        },
                        onTapEdit: () => {},
                      );
                    } else {
                      return Center(
                        child: IconButton(
                          onPressed: () {
                            dialogBuilder(
                              context,
                              title: "Novo Exercicio",
                              content: CreateExerciseModal(
                                viewModel: widget.viewModel,
                                trainingId: widget.viewModel.trainingId,
                                onPressFinish: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add_rounded,
                            size: 40,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseInfo extends StatelessWidget {
  const ExerciseInfo({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).primaryTextTheme;

    return Row(
      children: [
        Text(
          "$label ",
          style: textStyle.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value, style: textStyle.bodyMedium),
      ],
    );
  }
}
