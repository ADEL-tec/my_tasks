import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tasks/core/extensions/context_extensions.dart';

class HeadContent extends StatelessWidget {
  const HeadContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Tasks",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontFamily: "Caprasimo",
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          context.localization.welcomeBack,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          context.localization.loginDescription,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 14.sp,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
