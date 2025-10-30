part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskAddedState extends TaskState {}

class TaskUpdatedState extends TaskState {}

class TaskDeletededState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TaskEntity> tasks;
  const TaskLoadedState(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskErrorState extends TaskState {
  final String message;
  const TaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}
