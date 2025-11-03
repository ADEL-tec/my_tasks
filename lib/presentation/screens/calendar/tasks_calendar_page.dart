import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../global.dart';
import '../../../logic/calendar_cubit/calendar_cubit.dart';
import '../../../logic/task_bloc/task_bloc.dart';
import '../../widgets/costum_bottom_navbar.dart';
import '../../widgets/default_app_bar.dart';
import '../task_list/widgets/task_item_card.dart';
import 'widgets/calendar_widget.dart';

class TasksCalendarPage extends StatefulWidget {
  const TasksCalendarPage({super.key});

  @override
  State<TasksCalendarPage> createState() => _TasksCalendarPageState();
}

class _TasksCalendarPageState extends State<TasksCalendarPage> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<TaskBloc>().add(
      LoadTasks(Global.authService.currentUser!.uid),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = context.watch<CalendarCubit>().state.selectedDate;
    final selectedTasks = context.watch<CalendarCubit>().state.selectedTasks;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<TaskBloc, TaskState>(
          listener: (context, state) {
            if (state is TaskLoadedState) {
              context.read<CalendarCubit>().selectDate(
                selectedDate,
                state.tasks,
              );
            }
          },
          builder: (context, state) {
            if (state is TaskLoadedState) {
              return Column(
                children: [
                  DefaultAppBar(title: 'Tasks Calendar'),
                  CalendarWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          DateFormat('EEEE, MMM d').format(selectedDate),
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: selectedTasks.isEmpty
                        ? Center(
                            child: Text(
                              "No tasks for this date",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: selectedTasks.length,
                            itemBuilder: (context, index) {
                              final task = selectedTasks[index];
                              return TaskItemCard(task, index: index);
                              // Container(
                              //   margin: const EdgeInsets.only(bottom: 12),
                              //   decoration: BoxDecoration(
                              //     color: theme.colorScheme.surface,
                              //     borderRadius: BorderRadius.circular(16),
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Colors.black12,
                              //         blurRadius: 6,
                              //         offset: const Offset(0, 3),
                              //       ),
                              //     ],
                              //   ),
                              //   child: ListTile(
                              //     leading: CircleAvatar(
                              //       backgroundColor: Colors.amber,
                              //       child: const Icon(
                              //         Icons.task_alt,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //     title: Text(task.title),
                              //     subtitle: Text(
                              //       DateFormat.d().add_M().format(
                              //         task.dueDate ?? task.createdAt!,
                              //       ),
                              //     ),
                              //     trailing: IconButton(
                              //       icon: const Icon(Icons.edit_outlined),
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              // );
                            },
                          ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
      bottomNavigationBar: CostumBottomNavbar(2),
    );
  }
}
