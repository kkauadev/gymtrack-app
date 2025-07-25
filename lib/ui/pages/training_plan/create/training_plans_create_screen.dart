import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/training_plan.dart';
import 'package:gymtrack/ui/core/widgets/button.dart';
import 'package:gymtrack/ui/core/widgets/dropdown.dart';
import 'package:gymtrack/ui/core/widgets/text_form_field.dart';
import 'package:gymtrack/ui/pages/training_plan/create/training_plan_create_view_model.dart';
import 'package:gymtrack/ui/pages/training_plan/my_training_plans/my_training_plans_screen.dart';

class TrainingPlansCreateScreen extends StatefulWidget {
  static const _pathTemplate = '/training-plan/:userId/create';

  static String name = '/create';

  static String getPath(Map<String, String> params) {
    var path = _pathTemplate;
    params.forEach((key, value) => path = path.replaceAll(':$key', value));
    return path;
  }

  const TrainingPlansCreateScreen({
    super.key,
    required this.viewModel,
  });

  final TrainingPlanCreateViewModel viewModel;

  @override
  State<StatefulWidget> createState() => TrainingPlansCreateScreenState();
}

TrainingPlanLevel parseLevel(String? value) {
  return switch (value) {
    'Basico' => TrainingPlanLevel.basic,
    'Intermediario' => TrainingPlanLevel.intermediary,
    'Avancado' => TrainingPlanLevel.advanced,
    _ => TrainingPlanLevel.basic
  };
}

TrainingPlanType parseType(String? value) {
  return switch (value) {
    'Cardio' => TrainingPlanType.cardio,
    'Exercicio' => TrainingPlanType.exercise,
    _ => TrainingPlanType.exercise
  };
}

class TrainingPlansCreateScreenState extends State<TrainingPlansCreateScreen> {
  final formKey = GlobalKey<FormState>();

  String? name;
  String? pathologies;
  String? observation;
  String? nivel;
  String? type;
  String? visibility;
  int? timeInDays;

  final List<String> dropdownTypeItems = ['Cardio', 'Exercicio'];
  final List<String> dropdownLevelItems = ['Option 1', 'Option 1', 'Option 1'];

  @override
  Widget build(BuildContext context) {
    void onSubmit() {
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState?.save.call();
        widget.viewModel.saveTrainingPlan.execute(
          TrainingPlan(
            name: name?.trim() ?? "",
            pathology: pathologies?.trim() ?? "",
            authorId: widget.viewModel.userId,
            timeInDays: timeInDays ?? 0,
            observation: observation?.trim() ?? "",
            level: parseLevel(nivel),
            type: parseType(type),
            visibility: TrainingPlanVisibility.private,
          ),
        );
      }
    }

    var textStyle = Theme.of(context)
        .textTheme
        .headlineSmall
        ?.copyWith(fontWeight: FontWeight.bold);

    showSuccessDialog() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  "O seu plano de treino foi criado com sucesso.",
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Button(
                  label: "Continuar",
                  onPressed: () async {
                    await context.push(MyTrainingPlansScreen.getPath(
                      {'userId': widget.viewModel.userId},
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Plano de Treino"),
        centerTitle: true,
      ),
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
                  Dropdown(
                    label: Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
                      child: Text("Tipo"),
                    ),
                    items: dropdownTypeItems,
                    onSelected: (value) => setState(() => type = value),
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
                    items: dropdownLevelItems,
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
                  Button(label: "Criar", onPressed: onSubmit),
                  CommandBuilder(
                    command: widget.viewModel.saveTrainingPlan,
                    onData: (ctx, retur, obj) {
                      Future.microtask(showSuccessDialog);
                      return SizedBox.shrink();
                    },
                  )
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
