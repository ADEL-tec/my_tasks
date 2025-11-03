import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../logic/calendar_cubit/calendar_cubit.dart';
import '../../../../logic/task_bloc/task_bloc.dart';
import '../task_calendar_controller.dart';
import 'task_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../core/values/values.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(12.w),
          padding: EdgeInsets.symmetric(horizontal: Values.horizontalPadding),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(Values.buttonRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12.w,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: SfCalendar(
            view: CalendarView.month,
            dataSource: TaskDataSource(
              TaskCalendarController.getAppointments(
                context,
                (context.read<TaskBloc>().state as TaskLoadedState).tasks,
              ),
            ),
            todayHighlightColor: theme.colorScheme.primary,
            showNavigationArrow: true,
            headerHeight: 60.h,
            headerStyle: CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
                color: theme.colorScheme.onSurface,
              ),
              backgroundColor: theme.colorScheme.surface,
              // formatButtonVisible: false,
            ),
            viewHeaderHeight: 0,
            selectionDecoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(65),
              borderRadius: BorderRadius.circular(12.w),
              border: Border.all(color: theme.colorScheme.primary, width: 2),
            ),
            onSelectionChanged: (details) {
              context.read<CalendarCubit>().selectDate(
                details.date!,
                (context.read<TaskBloc>().state as TaskLoadedState).tasks,
              );
            },
            monthViewSettings: const MonthViewSettings(
              showAgenda: false,
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
              dayFormat: 'd',
              showTrailingAndLeadingDates: true,
              numberOfWeeksInView: 6,
            ),
            cellBorderColor: Colors.transparent, // clean look
          ),
        );
      },
    );
  }
}
