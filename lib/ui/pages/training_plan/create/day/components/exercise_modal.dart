import 'package:flutter/material.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';

class ExerciseAddModalData {
  final String name;
  final String? observation;
  final String? description;
  final int reps;
  final int sets;

  ExerciseAddModalData({
    required this.name,
    required this.observation,
    required this.description,
    required this.reps,
    required this.sets,
  });
}

void showAddExerciseModal(
  BuildContext context,
  void Function(ExerciseAddModalData data) onConfirm,
) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController observationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController repsController = TextEditingController();
  final TextEditingController setsController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void onPressedFinish() {
    if (!formKey.currentState!.validate()) return;

    final createdExercise = ExerciseAddModalData(
      name: nameController.text.trim(),
      observation: observationController.text.trim().isEmpty
          ? null
          : observationController.text.trim(),
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      sets: int.parse(setsController.text.trim()),
      reps: int.parse(repsController.text.trim()),
    );

    onConfirm(createdExercise);
    Navigator.of(context).pop();
  }

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Adicionar Exercício"),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nome do exercício'),
                  validator: (value) {
                    if (value == null || value.trim().length < 3) {
                      return 'Nome deve ter no mínimo 3 caracteres';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: observationController,
                  decoration: InputDecoration(labelText: 'Obervacao'),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Descricao'),
                ),
                TextFormField(
                  controller: setsController,
                  decoration: InputDecoration(labelText: 'Series'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null || parsed <= 0) {
                      return 'Informe um número válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: repsController,
                  decoration: InputDecoration(labelText: 'Repetições'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null || parsed <= 0) {
                      return 'Informe um número válido';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [Button(label: "label", onPressed: onPressedFinish)],
      );
    },
  );
}
