import 'package:flutter/material.dart';
import '../../../domain/entities/task_entity.dart';

import 'widgets/task_details.dart';

class TaskController {
  static void showTaskDetails(BuildContext context, TaskEntity task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (ctx) {
        return TaskDetails(task);
      },
    );
  }
}
