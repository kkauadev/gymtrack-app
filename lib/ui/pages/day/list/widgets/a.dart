import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/data/services/api/model/day_api_model.dart';
import 'package:gymtrack/routing/routes.dart';

class DayListWidget extends StatefulWidget {
  const DayListWidget({super.key, required this.item});

  final DayApiModel item;

  @override
  State<StatefulWidget> createState() => DayListWidgetState();
}

class DayListWidgetState extends State<DayListWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<ExerciseApiModel> exercises = [];

    exercises.addAll(widget.item.exercises);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => context.push(
            Routes.build(path: "/day", method: "/${widget.item.id}"),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            child: Text(
              widget.item.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Color(0xFF333333),
              ),
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
              GestureDetector(
                onTap: () => context.push(
                  Routes.build(path: "/day", method: "/${widget.item.id}"),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _isExpanded ? exercises.length : 1,
                  separatorBuilder: (ctx, idx) => SizedBox(height: 12),
                  itemBuilder: (ctx, idx) => exercises.isNotEmpty
                      ? ExerciseRow(exercise: exercises[idx])
                      : Text("Lista vazia"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (exercises.length != 1 && exercises.isNotEmpty)
                    GestureDetector(
                      onTap: () => setState(() => _isExpanded = !_isExpanded),
                      child: AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        curve: Curves.fastEaseInToSlowEaseOut,
                        duration: Duration(milliseconds: 200),
                        child: Image.asset(
                          "assets/caret-down.png",
                          fit: BoxFit.contain,
                          width: 32,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ExerciseRow extends StatelessWidget {
  const ExerciseRow({super.key, required this.exercise});

  final ExerciseApiModel exercise;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF333333),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Progressão de carga/aq",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Text(
          "4x12",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xFF333333),
          ),
        )
      ],
    );
  }
}
