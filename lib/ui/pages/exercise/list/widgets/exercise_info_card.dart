import 'package:flutter/material.dart';
import 'package:gymtrack/ui/pages/exercise/list/widgets/exercice_list_screen.dart';
import 'package:gymtrack/ui/pages/exercise/list/widgets/info_chip.dart';

class ExerciseInfoCard extends StatefulWidget {
  final String name;
  final String type;
  final int numberOfSets;
  final int numberOfReps;
  final String? description;
  final String? notes;
  final Function() onTapEdit;
  final Function() onTapDelete;

  const ExerciseInfoCard({
    super.key,
    required this.name,
    required this.type,
    required this.numberOfSets,
    required this.numberOfReps,
    required this.description,
    this.notes,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  State<StatefulWidget> createState() => ExerciseInfoCardState();
}

class ExerciseInfoCardState extends State<ExerciseInfoCard> {
  //_onTapEdit() {
  //  widget.onTapEdit();
  //}

  _onTapDelete() {
    widget.onTapDelete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          showTrailingIcon: false,
          childrenPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.name,
                style: Theme.of(context).primaryTextTheme.headlineMedium,
              ),
              Row(
                spacing: 8,
                children: [
                  InfoChip(
                      label: "Séries", value: widget.numberOfSets.toString()),
                  InfoChip(
                      label: "Reps", value: widget.numberOfReps.toString()),
                ],
              ),
            ],
          ),
          children: [
            Column(
              spacing: 8,
              children: [
                ExerciseInfo(label: "Tipo:", value: widget.type),
                if (widget.description != null &&
                    widget.description!.isNotEmpty) ...[
                  ExerciseInfo(label: "Descrição:", value: widget.description!),
                ],
                if (widget.notes != null && widget.notes!.isNotEmpty) ...[
                  ExerciseInfo(label: "Observações:", value: widget.notes!)
                ],
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  //GestureDetector(
                  //  onTap: _onTapEdit,
                  //  child: Icon(
                  //    Icons.edit,
                  //    size: 36,
                  //    color: Theme.of(context).colorScheme.onPrimary,
                  //  ),
                  //),
                  GestureDetector(
                    onTap: _onTapDelete,
                    child: Icon(
                      Icons.delete,
                      size: 36,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
