import 'package:flutter/material.dart';

class InformationTab extends StatelessWidget {
  const InformationTab({
    super.key,
    required this.name,
    this.pathology,
    this.observations,
    this.objective,
    required this.level,
    this.daysPerWeek,
    this.timeRecommendation,
  });

  final String name;
  final String? pathology;
  final String? observations;
  final String? objective;
  final int level;
  final int? daysPerWeek;
  final String? timeRecommendation;

  @override
  Widget build(BuildContext context) {
    levelText(int value) {
      switch (value) {
        case 2:
          return "Avançado";
        case 1:
          return "Intermediário";
        case 0:
          return "Iniciante";
        default:
          return null;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.headlineMedium),
              TrainingInformation(name: "Patologias", value: pathology),
              TrainingInformation(name: "Observações", value: observations),
              TrainingInformation(name: "Objetivo", value: objective),
              TrainingInformation(name: "Nível", value: levelText(level)),
              TrainingInformation(
                name: "Dias por semana",
                value: daysPerWeek?.toString(),
              ),
              TrainingInformation(
                name: "Recomendação de troca de treino após",
                value: timeRecommendation,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrainingInformation extends StatelessWidget {
  final String name;
  final String? value;

  const TrainingInformation({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

    return Visibility(
      visible: value != null,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          text: "$name: ",
          style: textStyle!.copyWith(fontWeight: FontWeight.bold),
          children: [TextSpan(text: value, style: textStyle)],
        ),
      ),
    );
  }
}
