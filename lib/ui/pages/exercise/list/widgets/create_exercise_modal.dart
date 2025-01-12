import 'package:flutter/material.dart';
import 'package:gymtrack/domain/models/exercise.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/dropdown.dart';
import 'package:gymtrack/ui/core/widgets/text_form_field.dart';
import 'package:gymtrack/ui/pages/exercise/list/view_models/exercise_list_view_model.dart';

class CreateExerciseModal extends StatefulWidget {
  const CreateExerciseModal({
    super.key,
    required this.viewModel,
    required this.trainingId,
    required this.onPressFinish,
  });

  final ExerciseListViewModel viewModel;
  final String trainingId;
  final void Function() onPressFinish;

  @override
  State<StatefulWidget> createState() => CreateExerciseModalState();
}

class CreateExerciseModalState extends State<CreateExerciseModal> {
  final formKey = GlobalKey<FormState>();
  String? name;
  String? description;
  int? repsNumber;
  int? setsNumber;
  String? level;
  String? observation;

  void onPressFinish() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save.call();
      widget.viewModel.saveExercise.execute(Exercise(
        name: name?.trim() ?? "",
        trainingId: widget.trainingId,
        description: description?.trim(),
        repsNumber: repsNumber ?? 0,
        setsNumber: setsNumber ?? 0,
        observation: observation?.trim(),
      ));
      widget.viewModel.load(widget.trainingId);
      widget.onPressFinish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            InputFormField(
              label: Text("Nome"),
              onSaved: (value) => name = value,
              validator: CreateExerciseModalValidator.name,
            ),
            InputFormField(
              label: Text("Descrição"),
              onSaved: (value) => description = value,
              validator: CreateExerciseModalValidator.description,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Expanded(
                  child: InputFormField(
                    label: Text("Número de séries"),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => repsNumber = int.tryParse(value ?? '0'),
                    validator: CreateExerciseModalValidator.repsNumber,
                  ),
                ),
                Expanded(
                  child: InputFormField(
                    label: Text("Número de repetições"),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => setsNumber = int.tryParse(value ?? '0'),
                    validator: CreateExerciseModalValidator.setsNumber,
                  ),
                ),
              ],
            ),
            Dropdown(
              label: Text("Número de séries"),
              onSelected: (value) => level = value,
              items: ["Iniciante", "Intermediário", "Avançado"],
            ),
            InputFormField(
              label: Text("Observações"),
              onSaved: (value) => observation = value,
              validator: CreateExerciseModalValidator.observation,
            ),
            SizedBox(height: 16),
            ValueListenableBuilder<bool>(
              valueListenable: widget.viewModel.saveExercise.isExecuting,
              builder: (context, isExecuting, child) {
                return Button(
                  label: !isExecuting ? "Salvar" : "Carregando",
                  onPressed: !isExecuting ? onPressFinish : () {},
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CreateExerciseModalValidator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "O nome não pode estar vazio.";
    }
    if (value.length < 3) {
      return "O nome deve ter pelo menos 3 caracteres.";
    }
    return null;
  }

  static String? description(String? value) {
    return null;
  }

  static String? repsNumber(String? value) {
    if (value != null && int.tryParse(value.trim()) == null) {
      return "Insira um número inteiro";
    }

    return null;
  }

  static String? setsNumber(String? value) {
    if (value != null && int.tryParse(value.trim()) == null) {
      return "Insira um número inteiro";
    }

    return null;
  }

  static String? level(String? value) {
    if (value == null || value.isEmpty) {
      return "Por favor, selecione uma opção.";
    }
    return null;
  }

  static String? observation(String? value) {
    return null;
  }
}
