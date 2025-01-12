import 'package:flutter/material.dart';
import 'package:gymtrack/ui/core/themes/extensions.dart';

class NotItemCard extends StatelessWidget {
  const NotItemCard({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final themeExtensions = Theme.of(context).extension<AppThemeDimensions>()!;

    return GestureDetector(
      //onTap: () =>
      //  context.push(Routes.build(path: "training-plan", method: "/create")),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(themeExtensions.padding.medium),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(
            themeExtensions.borderRadius.large,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: themeExtensions.margin.small,
          children: [
            Text(
              "Nenhum treino\nClique aqui para adicionar",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
            ),
            Icon(
              Icons.add_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.onTertiary,
            )
          ],
        ),
      ),
    );
  }
}
