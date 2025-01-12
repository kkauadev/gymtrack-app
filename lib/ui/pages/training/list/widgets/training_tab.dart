import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/training.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/pages/training/list/view_models/training_list_view_model.dart';
import 'package:gymtrack/ui/pages/training/list/widgets/training_info_card.dart';

class TrainingListView extends StatefulWidget {
  const TrainingListView({
    super.key,
    required this.items,
    required this.onPressedAdd,
    required this.viewModel,
  });

  final TrainingListViewModel viewModel;
  final List<Training> items;
  final void Function() onPressedAdd;

  @override
  State<StatefulWidget> createState() => TrainingListViewState();
}

class TrainingListViewState extends State<TrainingListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemCount: widget.items.length + 1,
        itemBuilder: (ctx, i) {
          if (i < widget.items.length) {
            return TrainingInfoCard(
              title: widget.items[i].name,
              muscleGroup: "Perna",
              onTap: () => context.push(
                Routes.build(
                  path: "/exercise",
                  method: "/list",
                  param: "/${widget.items[i].id}",
                ),
              ),
              onTapDelete: () {
                widget.viewModel.deleteTraining.execute(widget.items[i].id);
                widget.viewModel.loadTrainings.execute(
                  widget.viewModel.trainingPlanId,
                );
              },
            );
          } else {
            return Center(
              child: IconButton(
                onPressed: () => widget.onPressedAdd(),
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
    );
  }
}
