import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:my_tasks/presentation/screens/task_list/task_controller.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/values/values.dart';
import '../../../../domain/entities/task_entity.dart';
import '../../../../global.dart';
import '../../../../logic/task_bloc/task_bloc.dart';

class TaskItemCard extends StatefulWidget {
  const TaskItemCard(this.task, {super.key, required this.index});

  final TaskEntity task;
  final int index;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard>
    with SingleTickerProviderStateMixin {
  late final SlidableController _slidableontroller;

  @override
  void initState() {
    super.initState();
    _slidableontroller = SlidableController(this);
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.task.isDone ? Colors.green[300] : Colors.red[300];
    return Container(
      margin: EdgeInsetsDirectional.symmetric(
        horizontal: Values.horizontalPadding,
        vertical: 5.h,
      ),
      child: Slidable(
        useTextDirection: true,
        key: ValueKey(widget.index),
        controller: _slidableontroller,
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.editTask,
                  arguments: widget.task,
                );
              },
              backgroundColor: Colors.blue[300]!,
              label: context.localization.edit,
              borderRadius:
                  Directionality.of(context).name == TextDirection.RTL.spanText
                  ? BorderRadius.horizontal(
                      right: Radius.circular(Values.buttonRadius),
                    )
                  : BorderRadius.horizontal(
                      left: Radius.circular(Values.buttonRadius),
                    ),
            ),
            SlidableAction(
              onPressed: (context) =>
                  TaskController.showTaskDetails(context, widget.task),
              backgroundColor: Colors.green[300]!,
              label: context.localization.details,
              borderRadius:
                  Directionality.of(context).name == TextDirection.RTL.spanText
                  ? BorderRadius.horizontal(
                      left: Radius.circular(Values.buttonRadius),
                    )
                  : BorderRadius.horizontal(
                      right: Radius.circular(Values.buttonRadius),
                    ),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              _onDissmiss(context);
            },
            confirmDismiss: () async {
              return await _comfirmDissmiss(context);
            },
          ),
          children: [
            SlidableAction(
              onPressed: _onDissmiss,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(Values.buttonRadius),
            ),
          ],
        ),
        child: GestureDetector(
          onLongPress: () {
            if (Directionality.of(context).name == TextDirection.RTL.spanText) {
              _slidableontroller.openStartActionPane();
            } else {
              _slidableontroller.openEndActionPane();
            }
          },
          onTap: () {
            if (Directionality.of(context).name == TextDirection.RTL.spanText) {
              _slidableontroller.openEndActionPane();
            } else {
              _slidableontroller.openStartActionPane();
            }
          },
          child: Container(
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 10.w,
              vertical: 15.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Values.buttonRadius),
              border: Border(left: BorderSide(color: color!, width: 4)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withAlpha(40),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(1, 3),
                ),
              ],
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.task.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    Text(
                      widget.task.isDone
                          ? context.localization.done
                          : context.localization.notDone,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                        color: color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.task.dueDate == null
                      ? ".."
                      : DateFormat.yMd().add_jm().format(widget.task.dueDate!),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _comfirmDissmiss(context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text(
          'Do you sure you want to delete this task ?\n\n Titlet: ${widget.task.title}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx, true);
            },
            child: const Text('Delete'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('cancel'),
          ),
        ],
      ),
    );

    if (result == false) {
      _slidableontroller.close();
    }
    return result ?? true;
  }

  void _onDissmiss(context) {
    getIt<TaskBloc>().add(DeleteTask(widget.task.id!));
  }
}
