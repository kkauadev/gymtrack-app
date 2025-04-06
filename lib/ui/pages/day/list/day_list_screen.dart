import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:gymtrack/ui/core/widgets/default_loading.dart';
import 'package:gymtrack/ui/core/widgets/modal_builder.dart';
import 'package:gymtrack/ui/pages/day/list/day_list_view_model.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/a.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/create_day_modal.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/information_tab.dart';

class DayListScreen extends StatefulWidget {
  const DayListScreen({
    super.key,
    required this.viewModel,
  });

  final DayListViewModel viewModel;

  @override
  State<StatefulWidget> createState() => DayListScreenState();
}

class DayListScreenState extends State<DayListScreen> {
  _buildModal() {
    dialogBuilder(
      context,
      title: "Criar Treino",
      content: CreateDayModal(
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
            tabs: [Tab(text: "Dias de treino"), Tab(text: "Informações")],
          ),
          actions: [
            IconButton(
              onPressed: _buildModal,
              icon: Icon(Icons.add_rounded, size: 40, color: Colors.black),
            )
          ],
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 12, right: 12, bottom: 12),
              child: CommandBuilder(
                command: widget.viewModel.loadRecursiveDay,
                onData: (context, data, param) => ListView.separated(
                  shrinkWrap: true,
                  itemCount: data.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16),
                  itemBuilder: (_, i) => DayListWidget(item: data[i]),
                ),
              ),
            ),
            CommandBuilder(
              command: widget.viewModel.loadTrainingPlan,
              whileExecuting: (context, lastValue, param) => DefaultLoading(),
              onData: (context, data, param) => InformationTab(
                name: data!.name,
                level: data.level.index,
                visibility: data.visibility.index,
                daysPerWeek: data.timeInDays,
                objective: data.observation,
                observations: data.observation,
                pathology: data.pathology,
                timeRecommendation: data.timeInDays.toString(),
              ),
              onError: (context, p1, lastValue, p3) => Text(
                'Erro ao carregar planos de treino.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
