import 'package:flutter/material.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/ui/core/themes/colors.dart';

class DayCard extends StatefulWidget {
  const DayCard({
    super.key,
    required this.day,
    this.onTap,
    this.onLongPress,
    this.onTapDelete,
  });

  final Day day;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onTapDelete;

  @override
  State<StatefulWidget> createState() => DayCardState();
}

class DayCardState extends State<DayCard> {
  bool _toggleStar = false;
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

  _onTapStar() {
    setState(() => _toggleStar = !_toggleStar);
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
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.primary,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.day.trainingPlanId,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                : GestureDetector(
                    onTap: _onTapStar,
                    child: Icon(
                      Icons.star_rounded,
                      size: 48,
                      color: _toggleStar
                          ? Theme.of(context).colorScheme.warning
                          : Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
