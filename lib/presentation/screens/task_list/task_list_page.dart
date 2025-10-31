import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/routes/routes.dart';
import '../../../core/values/values.dart';
import '../../../domain/entities/task_entity.dart';
import '../../../logic/task_bloc/task_bloc.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/my_button.dart';

import '../../../global.dart';
import '../../widgets/costum_bottom_navbar.dart';
import 'widgets/task_item_card.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _btnController;
  late Animation<Offset> _btnAnimation;
  TaskFilter _selectedFilter = TaskFilter.all;

  @override
  void initState() {
    super.initState();
    _fetchData();

    // initialize the animation
    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _btnAnimation = Tween<Offset>(
      begin: Offset(0, 1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _btnController, curve: Curves.bounceOut));

    _btnController.forward();
  }

  void _fetchData() {
    context.read<TaskBloc>().add(
      LoadTasks(Global.authService.currentUser!.uid),
    );
  }

  @override
  void dispose() {
    _btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // AppBar
                  DefaultAppBar(title: context.localization.taskList),
                  // Filter Tabs
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFilterButton(
                          context.localization.all,
                          TaskFilter.all,
                        ),
                        _buildFilterButton(
                          context.localization.done,
                          TaskFilter.done,
                        ),
                        _buildFilterButton(
                          context.localization.notDone,
                          TaskFilter.notDone,
                        ),
                      ],
                    ),
                  ),
                  // const Divider(height: 0),
                  // SizedBox(height: 10.h),
                  Expanded(
                    child: RefreshIndicator.adaptive(
                      onRefresh: () async {
                        _fetchData();
                      },
                      child: BlocBuilder<TaskBloc, TaskState>(
                        builder: (BuildContext context, state) {
                          if (state is TaskLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is TaskLoadedState) {
                            if (state.tasks.isEmpty) {
                              return Center(child: Text('No tasks yet'));
                            }
                            final filteredTasks = _filterTasks(state.tasks);

                            if (filteredTasks.isEmpty) {
                              return const Center(
                                child: Text('No tasks found'),
                              );
                            }

                            return SlidableAutoCloseBehavior(
                              closeWhenOpened: true,
                              closeWhenTapped: true,
                              child: ListView.builder(
                                itemCount: filteredTasks.length,
                                shrinkWrap: true,
                                padding: EdgeInsetsDirectional.only(
                                  bottom: 70.h,
                                ),
                                itemBuilder: (ctx, index) {
                                  final task = filteredTasks[index];

                                  return TaskItemCard(task, index: index);
                                },
                              ),
                            );
                          } else if (state is TaskErrorState) {
                            return Center(
                              child: Text('Error: ${state.message}'),
                            );
                          }
                          return Center(
                            child: Text(
                              "There is no tasks",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 5,
              child: SlideTransition(
                position: _btnAnimation,
                child: MyButton(
                  btnType: ButtonType.primary,
                  text: context.localization.newTask,
                  icon: Icons.add,
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      AppRoutes.addTask,
                    );
                    if (result != null) {
                      _fetchData();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CostumBottomNavbar(1),
    );
  }

  Widget _buildFilterButton(String title, TaskFilter filter) {
    final isSelected = _selectedFilter == filter;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFilter = filter);
      },
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 20.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(Values.buttonRadius),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Filtering logic
  List<TaskEntity> _filterTasks(List<TaskEntity> tasks) {
    switch (_selectedFilter) {
      case TaskFilter.done:
        return tasks.where((t) => t.isDone).toList();
      case TaskFilter.notDone:
        return tasks.where((t) => !t.isDone).toList();
      default:
        return tasks;
    }
  }
}
