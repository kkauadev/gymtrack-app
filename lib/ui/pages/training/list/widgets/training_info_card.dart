import 'package:flutter/material.dart';

class TrainingInfoCard extends StatefulWidget {
  final String title;
  final String muscleGroup;
  final void Function() onTap;
  final void Function()? onLongPress;
  final void Function()? onTapDelete;

  const TrainingInfoCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.muscleGroup,
    this.onLongPress,
    this.onTapDelete,
  });

  @override
  State<StatefulWidget> createState() => TrainingInfoCardState();
}

class TrainingInfoCardState extends State<TrainingInfoCard> {
  bool _showDeleteButton = false;

  _onTapDelete() {
    if (widget.onTapDelete != null) widget.onTapDelete!();
  }

  @override
  Widget build(BuildContext context) {
    onTap() {
      if (_showDeleteButton == false) widget.onTap();

      setState(() => _showDeleteButton = false);
    }

    onLongPress() {
      setState(() => _showDeleteButton = true);

      if (widget.onLongPress != null) widget.onLongPress!();
    }

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.muscleGroup,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
            ),
            if (_showDeleteButton == true) ...[
              GestureDetector(
                onTap: _onTapDelete,
                child: Icon(
                  Icons.delete,
                  size: 28,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
