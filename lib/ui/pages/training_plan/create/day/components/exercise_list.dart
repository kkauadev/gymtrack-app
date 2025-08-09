import 'package:flutter/material.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/ui/pages/training_plan/create/day/components/exercise_modal.dart';
import 'package:gymtrack/ui/pages/training_plan/more_info/training_plan_more_info_screen.dart';

class ExerciseList extends StatefulWidget {
  final Day day;
  final TextEditingController controller = TextEditingController();

  ExerciseList({super.key, required this.day});

  @override
  State<StatefulWidget> createState() => ExerciseListState();
}

class ExerciseListState extends State<ExerciseList> {
  final TextEditingController controller = TextEditingController();
  void onTapButtonAdd() {
    showAddExerciseModal(
      context,
      (data) {
        if (widget.day.exercises
            .any((day) => day.name == data.name.toLowerCase())) {
          return;
        }
        setState(
          () => widget.day.exercises.add(
            Exercise(
              dayId: widget.day.id,
              name: data.name,
              description: data.description,
              observation: data.observation,
              repsNumber: data.reps,
              setsNumber: data.sets,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.day.exercises.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.day.exercises.length) {
          return SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onTapButtonAdd,
              label: Text("Adicionar exercicio"),
              icon: Icon(Icons.add_outlined),
            ),
          );
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ExerciseCard(exercise: widget.day.exercises[index]),
        );
      },
    );
  }
}
