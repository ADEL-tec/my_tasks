import '../../../domain/entities/task_entity.dart';

class TodayTasksResult {
  final List<TaskEntity> allToday;
  final List<TaskEntity> doneToday;

  TodayTasksResult({required this.allToday, required this.doneToday});
}

TodayTasksResult getTodayTasks(List<TaskEntity> tasks) {
  final now = DateTime.now();
  final startOfDay = DateTime(now.year, now.month, now.day);
  final endOfDay = startOfDay.add(const Duration(days: 1));

  final todayTasks = tasks.where((task) {
    final due = task.dueDate;
    return due != null && due.isAfter(startOfDay) && due.isBefore(endOfDay);
  }).toList();

  final doneTodayTasks = todayTasks.where((task) => task.isDone).toList();

  return TodayTasksResult(allToday: todayTasks, doneToday: doneTodayTasks);
}
