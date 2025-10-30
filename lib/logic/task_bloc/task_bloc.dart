import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repo.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  StreamSubscription? _taskSubscription;

  TaskBloc(this.taskRepository) : super(TaskInitialState()) {
    on<LoadTasks>(_onLoadTasks);
    on<_TasksUpdated>(_onTasksUpdated);
    on<_TasksError>(_onTasksError);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoadingState());

    // cancel previous stream if any
    await _taskSubscription?.cancel();

    _taskSubscription = taskRepository
        .getTasks(event.userId)
        .listen(
          (tasks) {
            add(_TasksUpdated(tasks));
          },
          onError: (error) {
            final errorMessage = error is FirebaseException
                ? error.message ?? 'Firebase error'
                : error.toString();
            add(_TasksError(errorMessage));
          },
        );
  }

  Future<void> _onTasksUpdated(
    _TasksUpdated event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoadedState(event.tasks));
  }

  Future<void> _onTasksError(_TasksError event, Emitter<TaskState> emit) async {
    emit(TaskErrorState(event.message));
  }

  FutureOr<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoadingState());
      await taskRepository.addTask(event.task);
      emit(TaskAddedState());
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  FutureOr<void> _onUpdateTask(
    UpdateTask event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(TaskLoadingState());
      await taskRepository.updateTask(event.task);
      emit(TaskUpdatedState());
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  FutureOr<void> _onDeleteTask(
    DeleteTask event,
    Emitter<TaskState> emit,
  ) async {
    try {
      emit(TaskLoadingState());
      await taskRepository.deleteTask(event.taskId);
      emit(TaskDeletededState());
    } catch (e) {
      emit(TaskErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _taskSubscription?.cancel();
    return super.close();
  }
}

// For fixing problem of calling emit inside listiner
class _TasksUpdated extends TaskEvent {
  final List<TaskEntity> tasks;
  const _TasksUpdated(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class _TasksError extends TaskEvent {
  final String message;
  const _TasksError(this.message);

  @override
  List<Object> get props => [message];
}
