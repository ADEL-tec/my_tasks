import '../entities/task_entity.dart';

abstract class TaskRepository {
  /// Add a new task
  Future<void> addTask(TaskEntity task);

  /// Update an existing task
  Future<void> updateTask(TaskEntity task);

  /// Delete a task by its ID
  Future<void> deleteTask(String taskId);

  /// Get all tasks for a specific user (real-time stream)
  Stream<List<TaskEntity>> getTasks(String userId);

  /// Get the count of tasks whose dueDate is today
  Future<int> getTodayTaskCount(String userId);
}
