import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/values/values.dart';
import '../../../../domain/entities/task_entity.dart';
import '../../../../global.dart';
import '../../../../logic/task_bloc/task_bloc.dart';
import 'task_details.dart';

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
      margin: EdgeInsets.symmetric(
        horizontal: Values.horizontalPadding,
        vertical: 5.h,
      ),
      child: Slidable(
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
              label: "Edit",
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(Values.buttonRadius),
              ),
            ),
            SlidableAction(
              onPressed: _showTaskDetails,
              backgroundColor: Colors.green[300]!,
              label: "Details",
              borderRadius: BorderRadius.horizontal(
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
            _slidableontroller.openEndActionPane();
          },
          onTap: () {
            _slidableontroller.openStartActionPane();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
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
                      widget.task.isDone ? "Done" : "Not Done",
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

  void _showTaskDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return TaskDetails(widget.task);
      },
    );
  }

  void _onDissmiss(context) {
    getIt<TaskBloc>().add(DeleteTask(widget.task.id!));
  }
}
