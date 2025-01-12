import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';

Future<void> trainingPlanExampleBuilder(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.asset(
                "assets/long-click-example.png",
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Clique e segure para excluir",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Clique e segure, após isso, clique na lixeira no canto direito para concluir a exclusão",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
              child: Button(label: "Entendi", onPressed: () => context.pop()),
            ),
          ],
        ),
      );
    },
  );
}
