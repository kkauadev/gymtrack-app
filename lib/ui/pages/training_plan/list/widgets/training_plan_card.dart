import 'package:flutter/material.dart';
import 'package:gymtrack/domain/models/training_plan.dart';

class TrainingPlanCard extends StatefulWidget {
  const TrainingPlanCard({
    super.key,
    required this.trainingPlan,
    this.onTap,
    this.onLongPress,
    this.onTapDelete,
  });

  final TrainingPlan trainingPlan;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onTapDelete;

  @override
  State<StatefulWidget> createState() => TrainingPlanCardState();
}

class TrainingPlanCardState extends State<TrainingPlanCard> {
  bool _showDeleteButton = false;

  _onTap() {
    if (_showDeleteButton == false) {
      if (widget.onTap != null) widget.onTap!();
    }
    setState(() => _showDeleteButton = false);
  }

  _onLongPress() {
    setState(() => _showDeleteButton = true);

    if (widget.onLongPress != null) widget.onLongPress!();
  }

  _onTapDelete() {
    if (widget.onTapDelete != null) widget.onTapDelete!();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textStyle = Theme.of(context).primaryTextTheme;

    return GestureDetector(
      onTap: _onTap,
      onLongPress: _onLongPress,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
        padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.trainingPlan.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            _showDeleteButton
                ? GestureDetector(
                    onTap: _onTapDelete,
                    child: Icon(
                      Icons.delete,
                      size: 40,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 36,
                    color: Colors.black,
                  )
          ],
        ),
      ),
    );
  }
}
