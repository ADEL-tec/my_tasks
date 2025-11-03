import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task_entity.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
    : super(CalendarState(selectedDate: DateTime.now(), selectedTasks: []));

  void selectDate(DateTime date, List<TaskEntity> allTasks) {
    final filtered = _filterTasksByDate(date, allTasks);
    emit(state.copyWith(selectedDate: date, selectedTasks: filtered));
  }

  void updateTasks(List<TaskEntity> allTasks) {
    final filtered = _filterTasksByDate(state.selectedDate, allTasks);
    emit(state.copyWith(selectedTasks: filtered));
  }

  List<TaskEntity> _filterTasksByDate(
    DateTime date,
    List<TaskEntity> allTasks,
  ) {
    return allTasks.where((task) {
      final taskDate = task.dueDate ?? task.createdAt!;
      return taskDate.year == date.year &&
          taskDate.month == date.month &&
          taskDate.day == date.day;
    }).toList();
  }
}
