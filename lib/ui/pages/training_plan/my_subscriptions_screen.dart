import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymtrack/domain/models/plan_day_progress.dart';
import 'package:gymtrack/ui/pages/training_plan/components/plan_subscribe_card.dart';
import 'package:gymtrack/ui/pages/training_plan/create_options/training_plans_create_options_screen.dart';
import 'package:gymtrack/ui/pages/training_plan/my_subscriptions_view_model.dart';

class MySubscriptionsScreen extends StatefulWidget {
  static const _pathTemplate = '/my-subscription/:userId';

  static String name = '/my-subscription/:userId';

  static String getPath(Map<String, String> params) {
    var path = _pathTemplate;
    params.forEach((key, value) => path = path.replaceAll(':$key', value));
    return path;
  }

  const MySubscriptionsScreen({
    super.key,
    required this.viewModel,
  });

  final MySubscriptionsViewModel viewModel;

  @override
  State<StatefulWidget> createState() => MySubscriptionsScreenState();
}

class MySubscriptionsScreenState extends State<MySubscriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    void navigateTrainingPlansList() =>
        context.push(TrainingPlansCreateOptionsScreen.getPath(
            {'userId': widget.viewModel.userId}));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TrainingPlansButton(
                  onTap: navigateTrainingPlansList,
                )
              ],
            ),
          ),
          CommandBuilder(
            command: widget.viewModel.list,
            whileExecuting: (context, lastValue, param) =>
                Center(child: CircularProgressIndicator()),
            onData: (context, data, param) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 8),
                  itemCount: data.length,
                  itemBuilder: (context, i) => PlanSubscribeCard(
                    data: data[i],
                    onTapInitDay: () async {
                      final plan = data[i];
                      final progressList = plan.planDayProgress
                          .whereType<PlanDayProgress>()
                          .toList();
                      final trainingDays = plan.trainingPlan.days;

                      if (trainingDays.isEmpty) return; // Proteção

                      // Último dia que teve progresso
                      final lastProgressDayId = progressList.isNotEmpty
                          ? progressList.last.dayId
                          : null;

                      // Determina o próximo dia
                      String nextDayId;

                      if (lastProgressDayId == null) {
                        // Nunca iniciou -> começa pelo primeiro
                        nextDayId = trainingDays.first.id;
                      } else {
                        final currentIndex = trainingDays
                            .indexWhere((d) => d.id == lastProgressDayId);

                        if (currentIndex == -1 ||
                            currentIndex + 1 >= trainingDays.length) {
                          // Último dia ou não encontrou -> reinicia pelo primeiro
                          nextDayId = trainingDays.first.id;
                        } else {
                          // Próximo dia sequencial
                          nextDayId = trainingDays[currentIndex + 1].id;
                        }
                      }

                      // Cria novo progresso
                      await widget.viewModel.createPlanDayProgress
                          .executeWithFuture(
                        Dto(planSubscriptionId: plan.id, dayId: nextDayId),
                      );
                    },
                  ),
                ),
              ),
            ),
            onError: (context, p1, lastValue, p3) => Center(
              child: Text('Erro ao carregar planos de treino.'),
            ),
          )
        ],
      ),
    );
  }
}

class TrainingPlansButton extends StatelessWidget {
  final void Function()? onTap;
  const TrainingPlansButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(Icons.assignment, size: 34, color: Colors.grey),
    );
  }
}
