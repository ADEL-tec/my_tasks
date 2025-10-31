import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_tasks/domain/entities/task_entity.dart';

import '../../task_list/widgets/task_item_card.dart';

class NotDoneTaskList extends StatefulWidget {
  const NotDoneTaskList(this.tasks, {super.key});

  final List<TaskEntity> tasks;

  @override
  State<NotDoneTaskList> createState() => _NotDoneTaskListState();
}

class _NotDoneTaskListState extends State<NotDoneTaskList> {
  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      closeWhenTapped: true,
      child: ListView.builder(
        itemCount: widget.tasks.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.only(bottom: 70.h),
        itemBuilder: (ctx, index) {
          final task = widget.tasks[index];
          return TaskItemCard(task, index: index);
        },
      ),
    );
  }
}
