import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/extensions/context_extensions.dart';
import 'home_controller.dart';
import '../../../global.dart';
import '../../../logic/task_bloc/task_bloc.dart';
import 'widgets/home_appbar.dart';

import '../../widgets/costum_bottom_navbar.dart';
import 'widgets/home_header.dart';
import 'widgets/not_done_task_list.dart';
import 'widgets/to_do_list_widget.dart';
import 'widgets/today_tasks_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getIt<TaskBloc>().add(LoadTasks(Global.authService.currentUser!.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
              return CircularProgressIndicator.adaptive();
            } else if (state is TaskLoadedState) {
              final todayTasksResult = getTodayTasks(state.tasks);
              final tasksDone = state.tasks
                  .where((task) => task.isDone)
                  .toList();
              final notDoneTasks = state.tasks.where((e) => !e.isDone).toList();
              return ListView(
                children: [
                  HomeAppBar(name: context.localization.user),
                  SizedBox(height: 30.h),
                  TodayTasksCard(todayTasksResult),
                  SizedBox(height: 20.h),
                  HomeHeader(
                    title: context.localization.toDo,
                    count: tasksDone.length,
                  ),
                  SizedBox(height: 10.h),
                  ToDoListWidget(tasksDone),
                  SizedBox(height: 20.h),
                  HomeHeader(
                    title: context.localization.inProgress,
                    count: notDoneTasks.length,
                  ),
                  SizedBox(height: 10.h),
                  NotDoneTaskList(notDoneTasks),
                ],
              );
            }
            return Text("-");
          },
        ),
      ),
      bottomNavigationBar: CostumBottomNavbar(0),
    );
  }
}
