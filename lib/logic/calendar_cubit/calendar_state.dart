part of 'calendar_cubit.dart';

class CalendarState extends Equatable {
  final DateTime selectedDate;
  final List<TaskEntity> selectedTasks;
  const CalendarState({
    required this.selectedDate,
    required this.selectedTasks,
  });

  CalendarState copyWith({
    DateTime? selectedDate,
    List<TaskEntity>? selectedTasks,
  }) {
    return CalendarState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTasks: selectedTasks ?? this.selectedTasks,
    );
  }

  @override
  List<Object> get props => [selectedDate, selectedTasks];
}
