import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/routing/routes.dart';
import 'package:gymtrack/ui/core/widgets/default_loading.dart';
import 'package:gymtrack/ui/core/widgets/modal_builder.dart';
import 'package:gymtrack/ui/pages/day/list/view_models/day_list_view_model.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/create_day_modal.dart';
import 'package:gymtrack/ui/pages/day/list/widgets/day_card.dart';
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
                Theme.of(context).colorScheme.primary.withValues(
                      alpha: 0.4,
                    ),
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
              child: Column(
                children: [
                  CommandBuilder(
                    command: widget.viewModel.loadDays,
                    whileExecuting: (context, lastValue, param) =>
                        Center(child: CircularProgressIndicator()),
                    onData: (context, data, param) => Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: data.length + 1,
                        itemBuilder: (context, i) {
                          if (i < data.length) {
                            return DayCard(
                              day: data[i],
                              onTap: () {
                                context.push(
                                  Routes.build(
                                    path: "/training",
                                    method: "/list",
                                    param: "/${data[i].id}",
                                  ),
                                );
                              },
                              onTapDelete: () => widget.viewModel.deleteDay(
                                data[i].id,
                              ),
                            );
                          } else {
                            return Center(
                              child: IconButton(
                                onPressed: _buildModal,
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 40,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    onError: (context, p1, lastValue, p3) => Center(
                      child: Text('Erro ao carregar planos de treino.'),
                    ),
                  )
                ],
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
