import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extensions/context_extensions.dart';
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
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: Values.horizontalPadding,
      ),
      child: Container(
        height: 100.h,
        width: double.infinity,
        padding: EdgeInsetsDirectional.all(18.w),
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
                  context.localization.today,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                ),
                Text(
                  Directionality.of(context).name == TextDirection.ltr.name
                      ? "${widget.tasksResult.doneToday.length}/${widget.tasksResult.allToday.length} ${context.localization.tasksDone}"
                      : "${context.localization.tasksDone} ${widget.tasksResult.allToday.length}/${widget.tasksResult.doneToday.length}",
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
