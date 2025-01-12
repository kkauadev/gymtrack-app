import 'package:flutter/material.dart';
import 'package:gymtrack/domain/models/training.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/text_form_field.dart';
import 'package:gymtrack/ui/pages/training/list/view_models/training_list_view_model.dart';

class CreateTrainingModal extends StatefulWidget {
  const CreateTrainingModal({
    super.key,
    required this.viewModel,
    required this.trainingPlanId,
    required this.onPressFinish,
  });

  final TrainingListViewModel viewModel;
  final String trainingPlanId;
  final void Function() onPressFinish;

  @override
  State<StatefulWidget> createState() => CreateTrainingModalState();
}

class CreateTrainingModalState extends State<CreateTrainingModal> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  void _onPressFinish() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save.call();
      var training = Training(
        name: nameController.text.trim(),
        trainingPlanId: widget.trainingPlanId,
      );
      widget.viewModel.saveTraining.execute(training);
      widget.viewModel.loadTrainings(widget.trainingPlanId);
      widget.onPressFinish();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            InputFormField(
              label: Text("Nome"),
              controller: nameController,
              validator: CreateTrainingModalValidator.name,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: widget.viewModel.saveTraining.isExecuting,
              builder: (context, isExecuting, child) {
                return Button(
                  label: isExecuting ? "Carregando" : "Salvar",
                  onPressed: isExecuting ? () {} : _onPressFinish,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CreateTrainingModalValidator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "O nome não pode estar vazio.";
    }
    if (value.length < 3) {
      return "O nome deve ter pelo menos 3 caracteres.";
    }
    return null;
  }
}
