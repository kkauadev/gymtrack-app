import 'package:flutter/material.dart';
import 'package:gymtrack/domain/models/day.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/text_form_field.dart';
import 'package:gymtrack/ui/pages/day/list/view_models/day_list_view_model.dart';

class CreateDayModal extends StatefulWidget {
  const CreateDayModal({
    super.key,
    required this.viewModel,
    required this.trainingPlanId,
    required this.onPressFinish,
  });

  final DayListViewModel viewModel;
  final String trainingPlanId;
  final void Function() onPressFinish;

  @override
  State<StatefulWidget> createState() => CreateDayModalState();
}

class CreateDayModalState extends State<CreateDayModal> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  void _onPressFinish() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save.call();

      var day = Day(trainingPlanId: widget.trainingPlanId);
      widget.viewModel.saveDay.execute(day);
      widget.viewModel.loadDays(widget.trainingPlanId);
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
              validator: CreateDayModalValidator.name,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: widget.viewModel.saveDay.isExecuting,
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

class CreateDayModalValidator {
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
