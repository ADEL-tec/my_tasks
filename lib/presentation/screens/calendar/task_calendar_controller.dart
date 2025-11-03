import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../domain/entities/task_entity.dart';

class TaskCalendarController {
  static List<Appointment> getAppointments(
    BuildContext context,
    List<TaskEntity> tasks,
  ) {
    return tasks
        .map(
          (task) => Appointment(
            startTime: task.dueDate ?? task.createdAt!,
            endTime: task.dueDate ?? task.createdAt!,
            color: Theme.of(context).colorScheme.tertiary,
            isAllDay: true,
          ),
        )
        .toList();
  }

  static List<TaskEntity> getTaskOfDay(
    List<TaskEntity> tasks,
    DateTime selectedDate,
  ) {
    return tasks.where((element) {
      return element.dueDate?.year == selectedDate.year &&
          element.dueDate?.month == selectedDate.month &&
          element.dueDate?.day == selectedDate.day;
    }).toList();
  }
}
