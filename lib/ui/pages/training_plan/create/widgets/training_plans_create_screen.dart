import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/dropdown.dart';
import 'package:gymtrack/ui/core/widgets/text_form_field.dart';
import 'package:gymtrack/ui/pages/training_plan/create/view_models/training_plan_create_view_model.dart';

class TrainingPlansCreateScreen extends StatefulWidget {
  const TrainingPlansCreateScreen(
      {super.key, required this.viewModel, required this.userId});

  final TrainingPlanCreateViewModel viewModel;
  final String userId;

  @override
  State<StatefulWidget> createState() => TrainingPlansCreateScreenState();
}

class TrainingPlansCreateScreenState extends State<TrainingPlansCreateScreen> {
  final formKey = GlobalKey<FormState>();

  String? name;
  String? pathologies;
  String? observation;
  String? nivel;
  int? timeInDays;

  final List<String> dropdownItems = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState?.save.call();
        widget.viewModel.saveTrainingPlan.execute(TrainingPlan(
          name: name?.trim() ?? "",
          pathology: pathologies?.trim() ?? "",
          userId: widget.userId,
          timeInDays: timeInDays ?? 0,
          observation: observation?.trim() ?? "",
        ));
        context.push(
          Routes.build(
              path: "/training-plan", param: "/${widget.viewModel.userId}"),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 8,
                children: [
                  InputFormField(
                    onSaved: (value) => name = value,
                    validator: TrainingPlansCreateValidator.name,
                    label: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                      child: Text("Nome"),
                    ),
                  ),
                  InputFormField(
                    onSaved: (value) => pathologies = value,
                    validator: TrainingPlansCreateValidator.pathologies,
                    label: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                      child: Text("Patologias"),
                    ),
                  ),
                  InputFormField(
                    onSaved: (value) => observation = value,
                    validator: TrainingPlansCreateValidator.observation,
                    label: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                      child: Text("Observacoes"),
                    ),
                  ),
                  Dropdown(
                    label: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                      child: Text("Nivel"),
                    ),
                    items: dropdownItems,
                    onSelected: (value) => setState(() => nivel = value),
                  ),
                  InputFormField(
                    onSaved: (value) => timeInDays = int.tryParse(value ?? "0"),
                    validator: TrainingPlansCreateValidator.timeInDays,
                    label: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                      child: Text("Dias por semana de treino"),
                    ),
                  ),
                  SizedBox(height: 12),
                  Button(label: "Criar", onPressed: onSubmit)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TrainingPlansCreateValidator {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "O nome não pode estar vazio.";
    }
    if (value.length < 3) {
      return "O nome deve ter pelo menos 3 caracteres.";
    }
    return null;
  }

  static String? pathologies(String? value) {
    return null;
  }

  static String? timeInDays(String? value) {
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
