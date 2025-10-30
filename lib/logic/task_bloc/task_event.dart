part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {
  final String userId;
  const LoadTasks(this.userId);
}

class AddTask extends TaskEvent {
  final TaskEntity task;
  const AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final TaskEntity task;
  const UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;
  const DeleteTask(this.taskId);
}
