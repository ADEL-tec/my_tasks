import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/task_entity.dart';

import '../../../../core/values/values.dart';
import '../../task_list/task_controller.dart';

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget(this.tasks, {super.key});

  final List<TaskEntity> tasks;
  @override
  State<ToDoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<ToDoListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.only(start: Values.horizontalPadding),
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return _buildCard(widget.tasks[index]);
        },
      ),
    );
  }

  _buildCard(TaskEntity task) {
    return GestureDetector(
      onTap: () => TaskController.showTaskDetails(context, task),
      child: Container(
        width: 150.w,
        padding: EdgeInsetsDirectional.all(10.w),
        margin: EdgeInsetsDirectional.only(end: 14.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(Values.horizontalPadding),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  task.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 10.w,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50.h),
                  ),
                ),
                Text(
                  "  till ${task.dueDate == null ? ".." : DateFormat("d MMM y").format(task.dueDate!)}",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
