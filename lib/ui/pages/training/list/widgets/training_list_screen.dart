import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/ui/core/widgets/default_loading.dart';
import 'package:gymtrack/ui/core/widgets/modal_builder.dart';
import 'package:gymtrack/ui/pages/training/list/view_models/training_list_view_model.dart';
import 'package:gymtrack/ui/pages/training/list/widgets/create_training_modal.dart';
import 'package:gymtrack/ui/pages/training/list/widgets/information_tab.dart';
import 'package:gymtrack/ui/pages/training/list/widgets/not_item_card.dart';
import 'package:gymtrack/ui/pages/training/list/widgets/training_tab.dart';

class TrainingListScreen extends StatefulWidget {
  const TrainingListScreen({
    super.key,
    required this.viewModel,
  });

  final TrainingListViewModel viewModel;

  @override
  State<StatefulWidget> createState() => TrainingListScreenState();
}

class TrainingListScreenState extends State<TrainingListScreen> {
  _buildModal() {
    dialogBuilder(
      context,
      title: "Criar Treino",
      content: CreateTrainingModal(
        viewModel: widget.viewModel,
        trainingPlanId: widget.viewModel.trainingPlanId,
        onPressFinish: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            dividerColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
            tabs: [
              Tab(text: "Treinos"),
              Tab(text: "Informações"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommandBuilder(
                command: widget.viewModel.loadTrainings,
                whileExecuting: (context, lastValue, param) => DefaultLoading(),
                onData: (context, d, param) => d.isNotEmpty
                    ? TrainingListView(
                        items: d,
                        onPressedAdd: _buildModal,
                        viewModel: widget.viewModel,
                      )
                    : Center(child: NotItemCard(onTap: _buildModal)),
                onError: (context, p1, lastValue, p3) => Center(
                  child: Text('Erro ao carregar treinos.'),
                ),
              ),
            ),
            CommandBuilder(
              command: widget.viewModel.loadTrainingPlan,
              whileExecuting: (context, lastValue, param) => DefaultLoading(),
              onData: (context, data, param) => InformationTab(
                name: data!.name,
                level: 1,
                daysPerWeek: data.timeInDays,
                objective: "23wdas",
                observations: data.observation,
                pathology: data.pathology,
                timeRecommendation: "2 meses ",
              ),
              onError: (context, p1, lastValue, p3) {
                return Text('Erro ao carregar planos de treino.');
              },
            ),
          ],
        ),
      ),
    );
  }
}
