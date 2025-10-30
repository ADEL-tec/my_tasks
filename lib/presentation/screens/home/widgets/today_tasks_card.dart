import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../global.dart';
import '../../../../logic/task_bloc/task_bloc.dart';

import '../../../../core/values/values.dart';
import '../home_controller.dart';

class TodayTasksCard extends StatefulWidget {
  const TodayTasksCard(this.tasksResult, {super.key});

  final TodayTasksResult tasksResult;
  @override
  State<TodayTasksCard> createState() => _TodayTasksCardState();
}

class _TodayTasksCardState extends State<TodayTasksCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.horizontalPadding),
      child: Container(
        height: 100.h,
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Values.buttonRadius),
          color: Theme.of(context).colorScheme.onTertiaryContainer,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Today",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
                Text(
                  "${widget.tasksResult.doneToday.length}/${widget.tasksResult.allToday.length} Tasks Done",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
