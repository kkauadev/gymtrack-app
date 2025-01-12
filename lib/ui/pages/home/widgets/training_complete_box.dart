import 'package:flutter/material.dart';
import 'package:gymtrack/ui/core/themes/colors.dart';

class TrainingCompleteBox extends StatelessWidget {
  final bool completed;
  final void Function()? onTap;

  const TrainingCompleteBox({super.key, this.onTap, required this.completed});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Color defineColor(Color color1, Color color2) =>
        completed ? color1 : color2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: defineColor(
            colorScheme.surfaceCard,
            colorScheme.surfaceCardSecondary,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          completed
                              ? "Treino de hoje finalizado"
                              : "Faça seu trenio de hoje!",
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).primaryTextTheme.displaySmall,
                        ),
                      ),
                      Text(
                        completed ? "Parabens!" : "Treino de perna",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).primaryTextTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                completed ? Icons.done_rounded : Icons.priority_high_rounded,
                size: 86,
                color: completed
                    ? colorScheme.onSurfaceCard
                    : colorScheme.onSurfaceCardSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
