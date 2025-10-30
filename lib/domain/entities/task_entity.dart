enum TaskFilter { all, done, notDone }

class TaskEntity {
  final String? id;
  final String title;
  final String? description;
  final bool isDone;
  final String userId;
  final DateTime? createdAt;
  final DateTime? dueDate;
  final DateTime? completeDate;

  const TaskEntity({
    this.id,
    required this.title,
    this.description,
    this.isDone = false,
    required this.userId,
    required this.createdAt,
    required this.dueDate,
    this.completeDate,
  });
}
