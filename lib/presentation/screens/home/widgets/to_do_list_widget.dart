import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entities/task_entity.dart';

import '../../../../core/values/values.dart';

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
      height: 200.h,
      width: 300.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.tasks.length,
        itemBuilder: (context, indeex) {
          return _buildCard(widget.tasks[indeex]);
        },
      ),
    );
  }

  _buildCard(TaskEntity task) {
    return Container(
      width: 200.w,
      padding: EdgeInsetsDirectional.all(10.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(Values.horizontalPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Container(
                height: 20.w,
                width: 20.w,
                decoration: BoxDecoration(
                  color: task.isDone ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(50.h),
                ),
              ),
              SizedBox(width: 20.w),
              Text(
                task.dueDate == null
                    ? ".."
                    : DateFormat.yMd().add_jm().format(task.dueDate!),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
